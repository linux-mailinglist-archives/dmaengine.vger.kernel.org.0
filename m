Return-Path: <dmaengine+bounces-10847-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG12NqEMFGo7JQcAu9opvQ
	(envelope-from <dmaengine+bounces-10847-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:47:29 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B1E5C8003
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 10:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B9523009B3A
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA983E317F;
	Mon, 25 May 2026 08:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WqvbC2Zt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UH3L8lDm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327B0329C71
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779698843; cv=none; b=QjRhr8tVK6CU2XareWUw0Rbj5YwoPU4qKNE1N+dxsZxxKA15k29P9OIomH7pMNNGnjTWO4JAE+VsJGS/Hf2iPsboceV4z+4dva02aozzJQjCTiEZ5/xkWdTIb0lVOvwyEw5koRBv0NyZ2jnWruP4rlVY7Ls9XoPV68V5cpufiAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779698843; c=relaxed/simple;
	bh=mqWAyYzTeltqWLp895g+IfBXkNn7FhOKUuWOA2N2Tos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUPriMHUIeFl0z1s82fXfo1ZSoD1UtX/TcLNjAu0H79C/KcDnOwJz6BhOpUiTR2/2nDsAMftFX//c/FcNFuI1Y1+HLAFsQRJaPZjJH43GrRctWrxBY+i2Vx7zSl3LsRS0FM8psJjOiFfMBT0RmA8swSRhBxuvCdmmg4F7ioeO5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WqvbC2Zt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UH3L8lDm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P6t0MS1566954
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 08:47:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Py2ZcyFPpkOLHS6KnXYGCXDC
	p49nDJlbDOBEgzr1gzU=; b=WqvbC2ZtdZQJuLvdYPPdfxrZgJDoZrQS+2h0LIEe
	guw46OFkQbV8zMTPR89uZbGM7nMmrGLPT9uEctg1Al48xinpd6MatA387X8Bb+q/
	LiHJTP35H47hty0zUSb0qJRcRckpsUrcgD/MExDAaGBScCiPyFIy3keAtuDidWC0
	NqPJxO0EkbFdJHiqHa+JmPKyLJoETKYyvWWDWBkAhwII8/RR2CkHfY3rZzD6yscB
	4QNSQwxovf5+ajSS4Fqg6jqgHErnQZaHG3Jpb/GgYE+gRc/to0ZgteGChRxmpn52
	NG/gjZXXisyfB4ongtJOsSIYbQVi5us2UQKCKLqazkHRgw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb4aswvku-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 08:47:20 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-516cde13e8cso81039931cf.1
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 01:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779698840; x=1780303640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Py2ZcyFPpkOLHS6KnXYGCXDCp49nDJlbDOBEgzr1gzU=;
        b=UH3L8lDmBT/EbhKqLFgXTFxZyf1lOiH3NBEXixU1RqvcQa3MaVSPkuCHy+VeKQYD9J
         /xYpvlWlvJpUDaukclNDvBYVIXwGEBksV7li3T3xV7qSS71baHhMw9knuk0iYIHzMxu0
         6HxqsWJ4L+fB4V0RxJEWpubW/K3M0Ky7AihdlP2q4yXMI0bf9Zzc2lLYops16lmT94JE
         XozAXF/hGBJOQAew22Wy2JOExCj4b5a8rpHbdYdw6FGozmg+49cEC6ikJmCesR0Nc+3p
         5M1zFgdGfHD0WHjcPfuklDZwbEmIDu/3mK7cYbtPIwSwhXZm9kAkgW7Afok9LImiFsVH
         LU5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779698840; x=1780303640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Py2ZcyFPpkOLHS6KnXYGCXDCp49nDJlbDOBEgzr1gzU=;
        b=owfMGJxX+UtGZbOkxsfjmkKHhpxEYsLKh7D8QPuWos2wtNZHUz3BPIrXtVmywgn0o1
         XFWmicaw7lMaFMyK/pbV8EONNZZ10e+lo04M7pYq961jLwked0Rfp6WgU8QVZcUrgXCV
         NQ/lPlM6GAYVq2dXD+MuNTlstfWUp+ORbucxArUdl1fN+1lpSQTFIoVeIfjPCNlJcKiF
         bAnwUMAhTIX8s11ZthKd+tO3PYzoCaxnDKrr1ZE+db7eSitKv6SHfUzD4A2uhXnH1hXt
         UrNriSL1wJTyW1u5EhhtpDjTQHo3D0lRUIvMYtcKtbANff1fOI6lhSeMM6JxhsTilsyp
         2ZmA==
X-Forwarded-Encrypted: i=1; AFNElJ9e+UoIOwPkw/PXlqOLbfC0WbQ90nZm6EQ+60GXC3J5bdQsnrc7gP8z34sbvX9gwbk6/9gEAycdc4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl5JQiuEMNfK8E3KoqTk4Gw9L+N6rRNQo89xecVyPGHn6hhmGP
	HsZrgh+bKuBSFRr99otdLxYcqX8PWBx/5FZJR10Bqh+Zr2bylJzDL+aqJe8QnLJ0h2Phm1j3qNX
	MP7RbRv4T7JbL210v8aYeiHxbSre0zAi2rvu20bvVpt7uqWzVlmROlhTcOUQ3bk8=
X-Gm-Gg: Acq92OG7/sV1YPgwkH5LHxJtMIuP8WoMYLUchXsSegKFUOHBsrv1nW7xeIrSxLlBOHe
	8ralC78A6RPVwiTrMpHhBdFnWkNqFRO/vFFzizUnn1CkzeDRJqixElajcnRwaU+qeEsr2eqE1Sv
	N2X+K/8mfsLSAEukbZcuBMUeIhYoBIWfZ53iv/+KOk9z0xjo4AZzIoq++OFwYV5IyL/H9uHFOGc
	5yYknEDmQ3xfzLbK2nJm0ZDl9LvOpwjO44VGKZTbJ38nK+DCfdFzn+hIaFoUDZ2rCBh+q/mIOh2
	wfFKLvJzqzlm0VYsgSA+v/8QfDmBI0B3iK3FbKLTxezLfKvUVzdrayL+4toGR0VNMY29Ez2/eVD
	27YDfjG6HRV29lHZJ2Vs9wuxY+algvmf0kPc7vsurOswAbJySTDSs788gwOKncL9IHWuGl/66vD
	Bdjr6KLDZCfkX+Ql0ue4gRedgo5K7z4y4NLbU=
X-Received: by 2002:ac8:7f8a:0:b0:516:889b:ac9b with SMTP id d75a77b69052e-516d4368673mr177873121cf.39.1779698840297;
        Mon, 25 May 2026 01:47:20 -0700 (PDT)
X-Received: by 2002:ac8:7f8a:0:b0:516:889b:ac9b with SMTP id d75a77b69052e-516d4368673mr177872931cf.39.1779698839834;
        Mon, 25 May 2026 01:47:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395dcc2ee1asm22206721fa.34.2026.05.25.01.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 01:47:18 -0700 (PDT)
Date: Mon, 25 May 2026 11:47:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: shikra: Add qcrypto node support
Message-ID: <algvollvttjlu4qpawi3gnhwponwml6pts47ebmcvrjvlryl3a@qjq5ildo4qsm>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260515-shikra_qcrypto-v1-3-80f07b345c29@oss.qualcomm.com>
 <8dfa0670-7605-497b-9d53-db9b4a8a3d8d@oss.qualcomm.com>
 <57c26520-42dd-4159-bd2a-69874945cbbe@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c26520-42dd-4159-bd2a-69874945cbbe@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA4OSBTYWx0ZWRfX6CA9UHANr6vS
 OX9PkhNgfvn4ArK0JvNEhMc95LAk7B8hR9YObIEtVfPSwv89dDzh72o5H2bZdvNgmw9J+S1JezJ
 qjbjvF/WqDV+gTlOcDHz4QIgSGXoLxBq0fV1rwU2OJP+CyxzVjaG1ajquu0p+7we+YuCzMpafnc
 u4wcwR9GDifctjTY29eiyeLS0rr3oKJgiP+F1GhMwyn8aFg5LqLPEZEJRYmOCpxMhiMU6oD6+wu
 zhC6+GVVu/vvoC6lQRUTUSEc8PXiun5H/nXBAiAYIp9mVTIX4Hj0MiMyAgeCk1M/8MBJDdNFkzx
 Dsw6NjCnh8SBgUPc/VdzzrgxI5gkqo0pnQIZadGE0HnQpZuaTL7PV8vCPSE0wVwEKBnBFHTMh9m
 aD59fJcvaV+LPnfE25qmsjMtw5bcY7vbo60AFDRCshW0Zs1zq6V2nWb6opo6aGJeNA3Qzn5d4Dh
 vu/jv2yAQ94pkS+DwVA==
X-Proofpoint-ORIG-GUID: nOnwxBydb_mN_U-U_mbHgU71lMotgT6r
X-Proofpoint-GUID: nOnwxBydb_mN_U-U_mbHgU71lMotgT6r
X-Authority-Analysis: v=2.4 cv=c6ebhx9l c=1 sm=1 tr=0 ts=6a140c98 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=icl0gEoJmf2k9FGJNiIA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250089
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-10847-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,gmail.com,gondor.apana.org.au,davemloft.net,kernel.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 84B1E5C8003
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 02:15:45PM +0530, Kuldeep Singh wrote:
> On 15-05-2026 15:58, Konrad Dybcio wrote:
> > On 5/14/26 9:23 PM, Kuldeep Singh wrote:
> >> Add qcrypto and cryptobam support for shikra target.
> >>
> >> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> >> ---
> >>  arch/arm64/boot/dts/qcom/shikra.dtsi | 35 +++++++++++++++++++++++++++++++++++
> >>  1 file changed, 35 insertions(+)
> >>
> >> diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
> >> index 262c488add1e..dbac0e901d6e 100644
> >> --- a/arch/arm64/boot/dts/qcom/shikra.dtsi
> >> +++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
> >> @@ -541,6 +541,41 @@ config_noc: interconnect@1900000 {
> >>  			#interconnect-cells = <2>;
> >>  		};
> >>  
> >> +		cryptobam: dma-controller@1b04000 {
> >> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
> >> +			reg = <0x0 0x01b04000 0x0 0x24000>;
> >> +			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>;
> >> +			#dma-cells = <1>;
> >> +			iommus = <&apps_smmu 0x84 0x0011>,
> >> +				 <&apps_smmu 0x86 0x0011>,
> >> +				 <&apps_smmu 0x92 0x0>,
> > 
> >> +				 <&apps_smmu 0x94 0x0011>,
> >> +				 <&apps_smmu 0x96 0x0011>,
> > 
> > These two entries are logically the same (SID & ~mask) as the first two,
> > does it still work if you remove them?
> 
> Yes, resulting sid is same for 84/94 and 86/92.
> Basically, the resulting sid could be same, it's an optimization which
> smmu is doing which can result in same SMR(Stream matching register)
> routing 2 different sid to same context bank.
> So, 2 sid can be used even though resulting sid remains same.
> 
> Also, DT usually dictates what hw capabilities are supported and hence,
> captured all apps entries here to match the hardware description.
> 
> I hope this answers your query.

It doesn't. Can we drop them?

> > 
> > 
> >> +				 <&apps_smmu 0x98 0x0001>,
> >> +				 <&apps_smmu 0x9F 0x0>;
> > 
> > Let's keep lowercase hex
> Sure, will update in next rev.
> Please note, I'll be clubbing patches together in one series as
> suggested by krzysztof and fix this too that time.
> 
> -- 
> Regards
> Kuldeep
> 

-- 
With best wishes
Dmitry

