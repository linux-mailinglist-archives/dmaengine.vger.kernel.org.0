Return-Path: <dmaengine+bounces-11296-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qcY6DnWcJmr7ZgIAu9opvQ
	(envelope-from <dmaengine+bounces-11296-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 12:41:57 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DE16553CE
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 12:41:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=lsFgojfe;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=PtegV+AV;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11296-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11296-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 120C730888AB
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 10:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9D13CF692;
	Mon,  8 Jun 2026 10:09:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECE73CF1E7
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 10:09:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913394; cv=none; b=Sa4oveIo23xKTzGyew1lTVsOj36vlrCBhIjai3VP4ySs4S0Ccc9XgrdPVnWFGzSOoeqa3oBxD+nFxsMTw6QIxVTzXi9sO1cm1QkTKEFeXWDMmewVxr4M5YzzheR6c3STubKFc9tqzEelJz+OOZUNDhaVrQOufbpwlD5Y+LSm9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913394; c=relaxed/simple;
	bh=8xtTBTXIDf7MfGw8Vi3PfMhZOCnYmOz3QGd5uTaJyVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3Jl6oHRMzQeNwJv80y4vsfuOfgorvnT+6f6iUn4FMlKYlEB03+zM9SFcyC2ejIIjAHYq1KcUq09fcxIfhwMOxPBIF+UoqLlsvafYg2vw+e8dIgl6Sdh9umvICc2yaED9kaSNhb12xjqC0JidGh4v5scw54+ieR9fmPJd+EvVBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lsFgojfe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PtegV+AV; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658A34w22882946
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 10:09:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6htNFMDsDnIKOIJ7Pg+h6BNVxf4do+RHck9LTOYbZTY=; b=lsFgojfeX1Y5tPxD
	YFrDw6WpPPBleXuQ1hDOnq7b1uK6UnEdPTgVe0kQzOKGF0JPXtjsFHXLQrw6Xg1k
	mnslkS6GXotP8/8OUKYcAxwLzDOzZ4LBFTMRL4CqPMTZzLi5g7IrDvdxKT5NliEf
	6sfWRVmvjE4m0gqxxleDPq7IMRelCe1H09puiw+TftdALY2xj6W+UgyL+buvDKo0
	4chm68bVosJY6L85fi5ou5zBRrt3wb6o22gaPz9d7C9MiV2BRDiEt64mETLP7q7E
	VMMlHfGtNWPm9ZR5DbnGEdFiUZ1cSWqAn/RaG1X23sCkhNvJZcFRLhU4eqFjwhGW
	SCv5bg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enun400yu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 10:09:51 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84245e2bb00so3750900b3a.1
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780913391; x=1781518191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6htNFMDsDnIKOIJ7Pg+h6BNVxf4do+RHck9LTOYbZTY=;
        b=PtegV+AVPdpE0LLPiEmOCOAE3HwAwPSvFzSNGVBRR6xgM/yxTW91bLP3eaDiSAi0G5
         fOoUEEgs/ZdkO7k9wWSY190ZfuH4LJyLxC6+I5mLYerELhBHRBNb3PDkXUj301+K4gDG
         Q+7jMgVeM/ZGsGYapI+0pduEog2j57QEvnCQmjo0l+xhfphIp8ombQtobjdE4Mxu2B45
         nLTIRhfY8c3Re04QAmTVzeRaSSJcYhs0l1lFm+LZNTBlCd5nK3XPR2TxkjtZCki3b4Ll
         CGgxCHO4Hfilxh8+7xho7h1twuu26sW6iBJra4EyJffB9Qikk7FYj2zvnAGym1Bl8b8J
         x3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780913391; x=1781518191;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6htNFMDsDnIKOIJ7Pg+h6BNVxf4do+RHck9LTOYbZTY=;
        b=E8LH1SzuhHD0WIg95AZkXvfy/jq3VNDwyRQSZ+GnVuVUSD/sDPz+b0Z/lU9rFrNLcj
         sEBvIVIsp5B1GvaA6a2I88nseuWoOHRXV4hcP4jTegv0cm/GpxjL1xHzBdz2VGNhGsOS
         SjwlnjpDrjEhyas6Fu4XETmWNSqigXoHPO8+4dECtIJUmWc/XWxOSq2WkS2WXUs77stn
         is6yBHNZkGBXeRd4wBg3DSRuO0AbuC82hkiDmrYtuzOh6LzHb6Q2Pu5zYkhWiNL4DI6v
         XVw/6HF7BtjC3mZSZzgM8diCOX6SRkp/K2aJaqq5EZZDUQ+bFxLzJ7wjIl/kX59qDTbt
         UDzg==
X-Forwarded-Encrypted: i=1; AFNElJ/Ssu9uK1GL7ZeanKlL504GcaVLdCgKDk7+V/Qg8IgDEnKNJguITs7RkXWEdccA0Bcv5+LriMOHfsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YycaCdTORGpsHe+Hfu8h2nTLxeK33ZFo3EyQpuMrcIMK6nnTdVH
	D2CslHSkp/SyfUDwfGQ7Bgkt5vHbqhv+uTiB8/wqDMnXEgCEeKVNTJdKEC5/w2FlefRw15wkzLn
	wuAjNDL6uA4+JAE16LLF0tPnp73YGLVSNoOPfXluQAAKoK4AgQgk7Hg2TwSLlVpA=
X-Gm-Gg: Acq92OFb3l0aEqrX4+aZDEhZvmssEGrOPIO8rktxoUJHGMOqBnZTn7lu2B6Aj3QDQmE
	8+vMgpoRtCTWebdcm5NZdI1C4395D+pP+UBoNCVlrH71PBUvN2/NuSz/3U1/d9Q21M1viJX8ao8
	lY5DxUau2FJwjGqgXF2EKiNDjP/bVxydAHm+VMnrf6n0S/hu5uFykPDmNcwJCamxYl+tbACNRvt
	z3vbLJuuJ2eci0/roVkWa2ofW7qfvvyDCUyCvYW2HYgWwCrVpdxq3wl4nxAN29onv1x1+hfvRW0
	+8J16s0AUtENRQeEthkXwDLmTDi/mlM4JkB0eemqRPtJiQmjFfpjzcLXLpFWiQL252UKpslqWHb
	8Xh1bQ+/ltuQQ3aiZn71OpLqw4mU3kDGkM37t8AhxdMJhNBKSypULkGhXeE8vX5Q=
X-Received: by 2002:a05:6a00:1c96:b0:82f:6e7:1527 with SMTP id d2e1a72fcca58-842b0f516b6mr13611981b3a.23.1780913390682;
        Mon, 08 Jun 2026 03:09:50 -0700 (PDT)
X-Received: by 2002:a05:6a00:1c96:b0:82f:6e7:1527 with SMTP id d2e1a72fcca58-842b0f516b6mr13611953b3a.23.1780913390128;
        Mon, 08 Jun 2026 03:09:50 -0700 (PDT)
Received: from [10.217.222.59] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282372a16sm21072093b3a.18.2026.06.08.03.09.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 03:09:49 -0700 (PDT)
Message-ID: <55039d7e-34df-4f89-8188-fcb45fdea538@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 15:39:43 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm64: dts: qcom: shikra: Add ICE, TRNG and QCE nodes
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com>
 <20260521-shikra_crypto_changse-v1-5-0154cc9cc0de@oss.qualcomm.com>
 <enovafjkiuzr4bciu6bu6hh7h56wvnaq5fh7f46m4h7browyrd@7huwa5egaqaq>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <enovafjkiuzr4bciu6bu6hh7h56wvnaq5fh7f46m4h7browyrd@7huwa5egaqaq>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA5MyBTYWx0ZWRfX/7ws8BhuV8eE
 J/0d2ILp5XdYlRzj+fUsR62EmTziUsK61hrANynO7xKQ5PXne6zkmHVQK1yjeYLo3EorqWfehEe
 3ZxTeuZztCA1IWw6bUdMeIErAjR0Jd9+Q2Srfw9QowiitwnkgX1sr5yPSCdrkdWOB7S1yBdflK6
 +a8BprPg76KzYYEyU6ZHJxaMTB/cnoGWkG6wotD/bFfkrDe+vHVO4DTJqeh6xU1UMB1OF5/kxG2
 TJzNvh9LiK3DK5Ty+iydtKQGrwgepbwqSVbsiqK4VIBOoTLLthBvQefuK8kw1Zo5xE6gaQtFtS3
 DQUrS1j7NcSFtbvKg9VdDsYSRcNoxClQFMi+qFKgdcu+iVd+YlSuG/FjsA6pPhWS+B/h7fXVRaB
 1rGR8qJyTBp4D7OUc4wr8n57bJfT8at9lGusTfZ5lY+0DOZRjTVTP9+PAuZ0rIi5IM/5ZgFRHFy
 aLDRhAGGiTAWRFpauXA==
X-Proofpoint-ORIG-GUID: JQUD4ispHNuvG5KDCP7bc77DDN2nH7TH
X-Authority-Analysis: v=2.4 cv=ZY4t8MVA c=1 sm=1 tr=0 ts=6a2694ef cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=Wdmx7GGFe5ciFpWgkT8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: JQUD4ispHNuvG5KDCP7bc77DDN2nH7TH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 spamscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080093
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-11296-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:dmitry.baryshkov@oss.qualcomm.com,m:konradybcio@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:vkoul@kernel.org,m:thara.gopinath@gmail.com,m:Frank.Li@kernel.org,m:agross@kernel.org,m:harshal.dev@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:tharagopinath@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com,oss.qualcomm.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 99DE16553CE

>> +		cryptobam: dma-controller@1b04000 {
>> +			compatible = "qcom,bam-v1.7.4", "qcom,bam-v1.7.0";
>> +			reg = <0x0 0x01b04000 0x0 0x24000>;
>> +			interrupts = <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH 0>;
>> +			#dma-cells = <1>;
>> +			iommus = <&apps_smmu 0x84 0x0011>,
>> +				 <&apps_smmu 0x86 0x0011>,
>> +				 <&apps_smmu 0x92 0x0>,
>> +				 <&apps_smmu 0x94 0x0011>,
> 
> 0x84 / 0x0011 is exactly the same as 0x94 / 0x0011. Likewise 0x96
> duplicates 0x86. Drop the duplicate IOMMU specifiers or explain in the
> commit message why they are required.

+Konrad too as there was same discussion in past too.

0x84/0x94 and 0x86/0x96 pairs are actually different even though
resulting sid is same.
Let me explain more.

From sid sheet,
Description	   SID (hex)	MASK	RESULT_SID	S1 CB
CE descriptors     0x84, 0x85	0x11	0x0084		S1_CRYPTO_KERNEL
(for data pipe 4/5)
CE descriptors	   0x86, 0x87	0x11	0x0086		S1_CRYPTO_USER
(for data pipe 6/7)
CE data pipe 4/5   0x94, 0x95	0x11	0x84(same)	S1_CRYPTO_KERNEL
CE data pipe 6/7   0x96, 0x97	0x11	0x86(same)	S1_CRYPTO_USER

Qualcomm BAM DMA engine driving QCE has 2 major components here:
* Descriptor pipe (0x84/0x86): This carries BAM command descriptors i,e
key, algorithm, length etc. which tell crypto engine what to do.
* Data pipe (0x94/0x96): This carries the actual data payload — the
plaintext/ciphertext buffers being read/written.

The descriptor(SID 0x84) basically contain IOVA address that points to
the data buffer. That same IOVA address is then used by the data pipe
(SID 0x94) to actually DMA the data.

Since, Crypto engine descriptor and crypto engine data are part of same
crypto operation and with the limited number of context banks, smmu
provides an optimization to logically group and resolve them to same
context bank/page tables.

Pipe 4/5 contain 2 SID(0x84/0x94) for kernel and pipe 6/7 contain
sid(0x86/0x96) for user. Pipe 4/5 doesn't touch pipe6/7 buffers so both
are safe.

-- 
Regards
Kuldeep


