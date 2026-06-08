Return-Path: <dmaengine+bounces-11285-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZiH5EhhYJmqaVAIAu9opvQ
	(envelope-from <dmaengine+bounces-11285-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 07:50:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F3A652EC2
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 07:50:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=FKO9bkDT;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=Vxbt5Mv5;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11285-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11285-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5BF25300158A
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 05:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C4D380FDC;
	Mon,  8 Jun 2026 05:50:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFC737BE6C
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 05:50:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780897809; cv=none; b=XkQMAfCIiPqL4nY86lxljmzzxjk3vCqjbQkLLWJ0dW7By6QTv1nCvGE24+r8aMoC0Ow5suRUUvEB/X8qVTJE/v6gX7NeCQDr0XXKm0kmOivnJ71tdeZJuxP1UTquokopoAvkb/PcxOECnQWhOh2dJ6zORxPPyoHFGzP8hoiStv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780897809; c=relaxed/simple;
	bh=tzYfBQhwfe94++DjT7L7DAHDGuFQ2dENINgETln1HJg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n+uUZ6S1SX829dgijUjJx3YXcd24g3kMQRlLfK9DzSdXxfTdRlZYWqavzS3Q82hFA5nKtltEql8oXKVIpa4H065GnHdicQVi4P6rTW9VEtbqysD9CgdyJApIVVgOfPSv/IL35xpdjXfut+enh1mdzz5YOBwJisNsp9BnZ/7HWqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FKO9bkDT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vxbt5Mv5; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580E9HT1534679
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 05:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rit6VWdw7gNECggAfevbaVkla2Yc5d08plhz2HlfCfA=; b=FKO9bkDT8wOmyjFe
	U7h/Ws3HXaxlbRzAk7l3PMNdSgrJaEeuXpz6soFHZq8uVP5rPkwjQy9+oRM4CRQb
	lxgGdPCGojTdOXsYEdTZrCoD3adpHtJBEGABKyUCDsmszjVDfUZx1mL+jaW72hkl
	2mGX8LlDwkEXg0m5YX8wIAiKqa8Ino2jDTJOpgQb5UIvQr2SmtH6q+fSwUYj1FNS
	JO8fpXP5bVMy/d5eUPVdw/S9B4kp/Tk82+YwV9afatLx/6YTgcD2mopNDfYdno/e
	agrutxtbIB87YgbypkmH08LMDB+NCrFoQAprMI5SrIFuMrwJeuiMvfH8YwI5vmAa
	JL5nFQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emagrecew-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 05:50:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0bf6904a6so54966235ad.1
        for <dmaengine@vger.kernel.org>; Sun, 07 Jun 2026 22:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780897807; x=1781502607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rit6VWdw7gNECggAfevbaVkla2Yc5d08plhz2HlfCfA=;
        b=Vxbt5Mv5QpHNwzLlSG4GpwPDaDWFuesQucsR9t88QJSEZ3uqli+Gqln3kPyOnsl+d2
         v94cDwEB8zOnp9/QM6QpdlH4QLb03mYdtmAse/B5r1tS64fn4i1lm1dgyPdDB+6XQ/V+
         mFqbnfAX6hXDGP8Vg3qcDRF7FxB7caTZhm2VrKoQ6g0psCfOGFD29T3sTKQdR2nifdK4
         ipYLuxzMTSCCxkrpMFfAm4ToMktnENv9QK9WNpKu89ba/R2XKyDXK2ch13sJlV4RqQdS
         FSO2qO2CnLtXds+0g0E3HfKRxRcugC4Iix4qvPrWq2sO/2qL+mr/0FBXrsK/d2DHZ053
         N5bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780897807; x=1781502607;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rit6VWdw7gNECggAfevbaVkla2Yc5d08plhz2HlfCfA=;
        b=QPyygTwmJ+Ur04AEjcCn5LOV9DpsAfJcvLN1o91AgguLyPIdnr7Q/A08w8Pnf8Xcit
         iguusqP7bKL4AyjXj52gIZ9ScqHTcYbZszBBGN/jmjDwcSI14JvntK1hNMc/NcT4hMzX
         uflc8cftF40sTTlKJr/sNLh8DYwtGTv86Zi3ku/FZ/2RRLfaGFMuuOQaiPOck11QakDL
         qpRvYgBPyQp6MLzv0r5tglix84t8scAbXGyQJHp3FGZhQ6WhOqMeYtPq6W/rrfmpZXFg
         Nd3VXNJRLXHaXf6eSVRosmrf5m02W9Tl7nth3Oiy98tekm+E53kIiU9kaPhkjGdMRt+1
         /aBA==
X-Forwarded-Encrypted: i=1; AFNElJ92oRgZG4mAckKp8MvSZfzIoVYfOZ+kaNSYN1VAeAS9JHO4jBSXUGFc3wlHZOqiLoeEoNihsCBRxj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrwGBl2+yccA8frPSh597+5fCfI7XXHNJ5A4ulWwc/lS+2Llx5
	/rA/CBskvE3AduNvavG+mCy8wBzchlTG+lk8qwQ3S7uuEkpHtCZTYgsHt+ay8ytMPgRJemmRVRP
	Ggrtr93dPo05UOtGVgujW8WGkHO6NitN6ptwRxl47+rUQ29+NozvGmC4I0CvmKlI=
X-Gm-Gg: Acq92OGzC/Gy/wjAaJwDuJnWP3N5IaPWFPNYHKnTHJZyvGQpxcZiHfq0qkHFRodL/o0
	wc3amOP9eb1K3o1MJMEC4zAFrsiyRiuYYylmRA7FgMzwWy/SSYCebgm0fI+lr4yxJZpyge65G6z
	R2IEILMRYFdbp6f760wBxCSN02HtsuJhq1c7Cz73ZthWsfEIlwXMlhpLaaPxYsMQCDdYIh/7j6h
	NxCVFMVi78jB+dRx+go69J/FUf0lruR5Cp6q+Mw0bEqsr3WuCl37JBFLTtyKosjwJXmXaMmXg1M
	dC5f+CJDV2ktvKnqCpG2y6KiIGpLcDRlqtqxwJsChteuTI2WtkxnAHLmq5ohe7dRf/7BhRTJQCN
	X9iyTXCkvU/q9YW1hoqoKput/i1wlYmnSUuOZBnshhYrv6EpMMCZ6nA4=
X-Received: by 2002:a17:903:3b8b:b0:2bf:114b:924 with SMTP id d9443c01a7336-2c1e85ca6b6mr168779135ad.34.1780897807051;
        Sun, 07 Jun 2026 22:50:07 -0700 (PDT)
X-Received: by 2002:a17:903:3b8b:b0:2bf:114b:924 with SMTP id d9443c01a7336-2c1e85ca6b6mr168778875ad.34.1780897806636;
        Sun, 07 Jun 2026 22:50:06 -0700 (PDT)
Received: from [10.152.201.53] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d45csm225747185ad.14.2026.06.07.22.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2026 22:50:06 -0700 (PDT)
Message-ID: <5c24a3f3-a4c0-43ec-9653-bc374a9c5e22@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 11:20:01 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] dma: qcom: bam_dma: Fix command element mask field for
 BAM v1.6.0+
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, Abhishek Sahu <absahu@codeaurora.org>,
        mani@kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        lakshmi.d@oss.qualcomm.com
References: <20260514-bam-fix-v5-1-58f6edb34969@oss.qualcomm.com>
 <agyeh4PZwG0Mu6Wx@vaman> <aiFXPPXtjCHj0Ged@hu-varada-blr.qualcomm.com>
Content-Language: en-US
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
In-Reply-To: <aiFXPPXtjCHj0Ged@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA1MCBTYWx0ZWRfXxcNXxW2oWjo8
 HH+gs/+PbjbMYvPjaEJx2U8ALxSo5DgpMM5MEi8rt6UJp6SAOflLgXviRtqG18bJkXw03/okEVf
 TcSdNqP/LrfRLx6kcSOZHwyNj6JWfQhmF9ToofyMEfJ793NLnkp+mNRnSkn0Gxp8Okp/OTIlou1
 l0rB4WLKnMgSUd1SmU1QchaBWymRFCuspO2yq1vcMCFq7V4UmYvW5x+QrXZ9MPiYcf7cvcusmlw
 AwR5YG9Ln98zS8L7olOgpmtbJ93SLKqd/8LHMyWgoE+1a80mw8obd9UoGZB19ipY/lWY5/YbM0/
 smBMeMGL5O6dXjCBc0D5v8jiugu0NQBmhQ9TArJFpbT+CQh/4eiYFn676jJc5jcqTepoTILoDjC
 GxQjM4jtSNbXdreJgDf46frS4PC/OVqXUQYjVK+3J20imNQY5RAlOK/Gm+FdDMw1izbAjYz6rMH
 Ryp0RnKv18J8gbVZ5gw==
X-Authority-Analysis: v=2.4 cv=G/4s1dk5 c=1 sm=1 tr=0 ts=6a26580f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=L4bHF1UehNEsD6MlcwUA:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kOzFikTQByLIthxnabMD0_ZcXyBEB1-_
X-Proofpoint-GUID: kOzFikTQByLIthxnabMD0_ZcXyBEB1-_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606080050
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11285-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[md.alam@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:varadarajan.narayanan@oss.qualcomm.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:absahu@codeaurora.org,m:mani@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lakshmi.d@oss.qualcomm.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:email,qualcomm.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[md.alam@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42F3A652EC2

Hi,

On 6/4/2026 4:15 PM, Varadarajan Narayanan wrote:
> On Tue, May 19, 2026 at 11:01:51PM +0530, Vinod Koul wrote:
>> On 14-05-26, 12:09, Varadarajan Narayanan wrote:
>>> From: Md Sadre Alam <md.alam@oss.qualcomm.com>
>>>
>>> BAM version 1.6.0 and later changed the behavior of the mask field in
>>> command elements for read operations. In newer BAM versions, the mask
>>> field for read commands contains the upper 4 bits of the destination
>>> address to support 36-bit addressing, while for write commands it
>>> continues to function as a traditional write mask.
>>
>> But this changes behaviour for all versions. What happens to folks on older
>> versions, wont this break for them, if not what am I missing

It will not have any impact on older version of BAM controller. Konrad 
also had a similar concern. Please refer to [1]

[1] 
https://lore.kernel.org/linux-arm-msm/2394e63f-1df7-764e-5489-3567065707a1@quicinc.com/

Thanks,
Alam.

