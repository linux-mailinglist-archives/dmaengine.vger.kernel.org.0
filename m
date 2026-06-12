Return-Path: <dmaengine+bounces-11492-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FbjrAmi3K2oPCwQAu9opvQ
	(envelope-from <dmaengine+bounces-11492-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 09:38:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2806774CC
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 09:38:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="MFdRN/il";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=QmEOP9FU;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11492-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11492-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 96C063019571
	for <lists+dmaengine@lfdr.de>; Fri, 12 Jun 2026 07:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217CA3E1231;
	Fri, 12 Jun 2026 07:37:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D663DEAC7
	for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 07:37:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781249872; cv=none; b=fpvsY4q/DG7fXYn9JHXbfgrpCYxQVRdRzD/mYmVc2DXOOglggmMeAcqaON+LdeKM11yG44uiySSU+QGwi81xBPkhUk50jBNDOkqCqfhDRNsV05om6o1zB7y2l8khP7QkD9hFGSXIbk7FgP0rsUbLkEYf+3G+k+8AUfAPEnWY4aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781249872; c=relaxed/simple;
	bh=qU3rvddbEAEf+sOsgGpXhGYeMFA0CB2x5S7vdbPsjlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnRdo+R/wMx83MS7/9fDun+9Bqv+7bszPj7NCiQrNhDLGy0kxBKdvHg5vLCoAgca8nzeaaVYDDojUxYAfW3CEknuZ8uG5H1gV1fQ9LInime7AqaSwTmHCXCqCKRN1ZmMiDhTRnRsu5gdBGZCMhBUbIMvVUt6b1rZlBuimcyPeFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MFdRN/il; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QmEOP9FU; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65C3CROP2506835
	for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 07:37:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=LqKFVOC0j90WTOOl7IKcMxfD
	Uw2Bsn86Jo/TQGF3Tl4=; b=MFdRN/ilDhylgFTY9jwTDhhgWfuwzMp3nlQLIIgp
	LShr6w7XlAIihowPQ01V8ot3nd48F4y7cy9viqQJPLBKxQfRokwFhXXEoW0Smn9J
	019/SJ7lDIymGzHkiOYrXqOTfPoT/tJQcHd/Innzkp1CgEJ/OaytiJrWSfYksmLR
	85BGRDUCzIgyodPaIyFarXNbFLyOKGN68GqF4ABsR3D5Dlnx5mfye/FWtgxXwl4x
	iD7Rq5qBMmJ51ADhJ0zuxJvjNhzQtrGvXqQeDXsptnk3/6Wj7j7E/wlDT+AobESR
	EyizJn0dW0AB3AO5KLzZ+OBRf0JCLS8sR96pJCmT5mMAiw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4er1cbjhr9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 07:37:48 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6e907a982f5so1907060137.0
        for <dmaengine@vger.kernel.org>; Fri, 12 Jun 2026 00:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781249868; x=1781854668; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LqKFVOC0j90WTOOl7IKcMxfDUw2Bsn86Jo/TQGF3Tl4=;
        b=QmEOP9FU4MKSigAeYYwb5aSQIjOAB0NvRe+M/FGbH9mUOPUUbur4bn1J4yqa7f2WBJ
         jmF4n17Vv0y7qyBCRdnU/kPiU9VDDl1RKYONOTaDxqYCSxqHkh3sFhMEjVTxd2g9xGk9
         ADjc/q6uS+++WVqtVGiq/RxsQcsbcOGQKQoc+BT1NeG31slj6Rm0D2+hNMbDpCcNL7Lw
         +09XTc2KKCh2QnfHAS1fcy4pHC4Ir0cDHF+5nk8KD9BPjOxBlraEZCHyHIfqOtBWoYp0
         tDaZE3/eAtxkjIIC2db+l5fe7AVYstq30/hCTQBkMk1Ya8qLKpDRzU6ZYVXq7ikc9Otg
         Tx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781249868; x=1781854668;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqKFVOC0j90WTOOl7IKcMxfDUw2Bsn86Jo/TQGF3Tl4=;
        b=aFR1olCnCYsfiihLvIU7KuFVnfMp8fXejerD5jl65H7qmvy/3vmt/35lxRdFD/Grzd
         u3Xi+IrlTR142n88qwfdJil1NFFhTlUTb5CcMHDZYso51ke/AG532SlgFiY1lkrywJj+
         Hofr45bnAqDa29z7XGgwdO+TmqSZGTbsfOUuuJiskjTz2echxViDXw/V9sFUz4d1PU+p
         Qm+jW1kT2PDSbRfCEwvBC1C+xA7DqjIu45gIN0NhxWpJgbzIswwrv8UiuETxgaw+WX+k
         lNWy6HQENMVdfq5wno8xo6GGrQOHUeghnsdkNZV+aOJGvcd4Uu2tCbNJFgt1oCnGyqVr
         hCKA==
X-Forwarded-Encrypted: i=1; AFNElJ/2gygdQ1aGZv2PI6jBacf5V3PGXjUOM6IPEpHW9icUfRm1DK+3ddt/CX7wHViQzotbQViunH/h3fY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeKHT75/aVVcu/Gxrj2y3rDFUdBgpVYT8aThvNzxgSzImlr0q+
	Hjth5e7FvDTSHlla5pgw7A7ktXmeQlreZ8Io0CoZVtc3NY2FJxVMXcAUqD1ya4SqHYottnMY4Br
	N6Tb8K5nu5T5pffEIPar3fbGTsleIiRtVxj8+yq0z7eHJbNB5UAleyqnRWZGKw30=
X-Gm-Gg: Acq92OHebh3W4L33W4r9H9AgBoepZi/CtYTI0WRV/v+6P1/MHUxBuddiGpFRifz/FfF
	mjYv/Q4BZZO7vopMm3MJAK7pczPxcHPHF+drdx1gAxtaiKSH2HpLVRcviyg8L4TGzI/dm1wfxI7
	0gNTgCevsGO/SEzqXg+drPHbgK8pFfr/leZQSo3HfnVRZs7vdOkATLzB+fMWcpGW2Q+gJ3lETSp
	HPtoqUwsDIpen3osf28tgEFPPjvbOLa5NNilrbWDHlKd6tj+OJ6UwrembTYRCqGN6HNqtMOvGCh
	zqjJ+gcGbaXJEZPtLPtvVAqygfDFxDPj+F+gAd4isHIq6oHqDJcNNNKPiAMOBrsPgfy0JuoVfe3
	Y7WPy3wh3ngdT32aAjS2d5gaiLm2G44Cjn3UnRTivOUftr19iK0WwuzieXgQhZiQ1ZbzgKc15WW
	N/lv5x/b7j3HdyLdu+s3B6Q+4uTRuSNj6+Y8o=
X-Received: by 2002:a05:6102:8604:20b0:6c5:94a0:37cf with SMTP id ada2fe7eead31-71e653032cbmr641065137.8.1781249867901;
        Fri, 12 Jun 2026 00:37:47 -0700 (PDT)
X-Received: by 2002:a05:6102:8604:20b0:6c5:94a0:37cf with SMTP id ada2fe7eead31-71e653032cbmr641061137.8.1781249867532;
        Fri, 12 Jun 2026 00:37:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-39929f190f5sm3867201fa.25.2026.06.12.00.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 00:37:45 -0700 (PDT)
Date: Fri, 12 Jun 2026 10:37:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Subject: Re: [PATCH v4 07/10] arm64: dts: qcom: shikra: Add CDSP, LPAICP,
 MPSS remoteproc PAS nodes
Message-ID: <sut2627vbby6gtkv3mrldko5nsdlvvwxozvwyk45xykzmgly63@6ke5dgwfhrqi>
References: <20260608-shikra-dt-m1-v4-0-2114300594a6@oss.qualcomm.com>
 <20260608-shikra-dt-m1-v4-7-2114300594a6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608-shikra-dt-m1-v4-7-2114300594a6@oss.qualcomm.com>
X-Proofpoint-GUID: YdloCtvDVqRV67Ys5M5-LKXDPW2wwr_A
X-Proofpoint-ORIG-GUID: YdloCtvDVqRV67Ys5M5-LKXDPW2wwr_A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEyMDA2NyBTYWx0ZWRfX6xpbVjKSSB+Q
 Zlg0hgn3bH7/itc+PIn8G0lzhtxTXbCmgyhSyd4N6E2FFMwdV1887vbauISDY+dgMaB6IbEFi2A
 NjdlMaXG9ieVt0zt/96ZDQnWTEN3zw8=
X-Authority-Analysis: v=2.4 cv=S57pBosP c=1 sm=1 tr=0 ts=6a2bb74c cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=l7gszL_yuYPfzADJGiwA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEyMDA2NyBTYWx0ZWRfX3mxiHN50B27R
 AsSOKOHg9uhpN+cOtLuv/NKFPRPSPUS17UdVyF4x6EDhyE38q0AUgxoWXPB3CuO8iGCaFDwKzcG
 LCD73NgZiC6pktzopOpjxXoTQreICWfKqMvZHnf8KuutSkkaZ8L0SRjLEXL48aHMwVwjAki5bhb
 1m9d+csuTvjDQ2SNfCJ1weGMgFC2yHBk4p0nfUclU/cwmPIUfpTfyQ6ygxGyBxOdGCeZko93uY3
 1zAQ837rz10dwZIuttuGinze+31tO7FVZKb3sj4waXIDj7pQO3ptIcJbCnYjM1uK17LFHMwd758
 FHGpDkvXS/ivuE5vyW1MVtXZCEG7Oi6JMBpEUqN8L789RmDGswPbGLzGi6L8gkNDM10fyWK4YpS
 MnHloQtH3VDBbKvmABxVK5trCwE/BJe6feJZy9r7wuS4fhxhjLKHOAh+DR6w1MV6PWSwpDyx8ue
 mhL8IcbvIm1bcNLW3DA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-12_01,2026-06-11_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606120067
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11492-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,6ke5dgwfhrqi:mid,qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:from_mime];
	FORGED_SENDER(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_RECIPIENTS(0.00)[m:komal.bajaj@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:krzk@kernel.org,m:djakov@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pm@vger.kernel.org,m:bibek.patro@oss.qualcomm.com,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitry.baryshkov@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC2806774CC

On Mon, Jun 08, 2026 at 06:40:27PM +0530, Komal Bajaj wrote:
> From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> 
> Add nodes for remoteproc PAS loader for CDSP, LPAICP, MPSS subsystem.
> 
> Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/shikra.dtsi | 164 +++++++++++++++++++++++++++++++++++
>  1 file changed, 164 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry

