Return-Path: <dmaengine+bounces-11338-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F2i9GGENJ2pmqwIAu9opvQ
	(envelope-from <dmaengine+bounces-11338-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 20:43:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13441659D18
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 20:43:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=Vb+5NiyN;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=SaBlmrvi;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11338-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11338-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56B6B300C0E2
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 18:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585A83E51FC;
	Mon,  8 Jun 2026 18:43:32 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153043E3D9D
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 18:43:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780944212; cv=none; b=un0pAiIsDo7qjwflI7lbqGEGfnsN9VU5RRtPiMBZO9ObgsvR8sBotaORd3xUwluIsDESwsnpPu8fYt97qQ2m+mn1y8dD3Lv/w7qTNYeii/d83fRALFD+CAYWJFXih69FDCa9MDCvrFHqac8+8y9t9tMn7CQtS4GS42BP1rWK6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780944212; c=relaxed/simple;
	bh=XrTiGoAfj95ZNVlfxHtjtlmUqJv9XRx7IJtBxarrPnQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lXyHduR7naxu//NcW0uPqsVv+0CteemLTkc8P4l110Jjg664e/mKpPhMhqwDB5GbYnkNjDY+9r8jJ9DeqS4WeUuSDp4gwTL1rNhZHVCaQeRJw/edfXfZmguMK4mw7BQFb2qWirohPjdS1+/fQt7+nQjYS/NDbzL3/6zvsBg8xws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vb+5NiyN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SaBlmrvi; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658FFW0N3971356
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 18:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Plr6hTzFD6LbDZNeKPjpGhAAeO93r9oSiZKDt2c59H8=; b=Vb+5NiyNxznEyJtl
	l4PuNB9RZ3Bv0pBTGl8aCbsRL3qwtEfljk5lF4r1QqZ7JPnEZRiNIxs1IPce6/LL
	C8hBPQwEanaLG/qn9mtl0SWguf+ZmtMJDKFlACLCn+6pS+A3mHf3+zDxTqB4gbOO
	b3tlHTLUBJmIxK0g8ZaLf9C2QUJsNkj7e9E+YmEiIeF/Bg3WOstY+kfdSdGv9iwW
	dDGhOAj4MopmEFvnK+qq6SHxKtdeXJ2ImhbVh3PRWvJiR+YFGbVgyvBX0jQNLyHy
	zMg7j7dnVW9gRG14afbcmBNP13Ax551WjN10pve/hMCATRXT1ffrMjeiGu/ksyLK
	F4fBuQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuptjemg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 18:43:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2c0b35fa876so57731735ad.1
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 11:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780944209; x=1781549009; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Plr6hTzFD6LbDZNeKPjpGhAAeO93r9oSiZKDt2c59H8=;
        b=SaBlmrviuFbLUx7GG/PR156mS53QN2EjpAddU0p65c35UzP0APIUAUVJr6SELqdSuD
         vomYb8iLh/XU18kIoqW0mQANkYl62GdIjJeoY4N3Z5JMmoHJC1ovKaWMR7MHLNztRPvX
         4HXkG01JdzuImg4fTth7Y3W1gYswdlKRLK0majjYuuJiEU9l7QCeorLiBO7yBIBvof/m
         /LEnWKs6ctNmiMRQuCEUAqIaAMnHJdM+3CYTTAFirUT142KNb3pKhMJ0NRWlfseBM25R
         H6Pn172urXYEhQHdZGqegMdX1HXO9m68rlpy+fT2k7xX7WTey7d58sXNTC0p3g0eQN2Z
         SafQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780944209; x=1781549009;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Plr6hTzFD6LbDZNeKPjpGhAAeO93r9oSiZKDt2c59H8=;
        b=eckd8zEi1s96h98wiHiS7yPvG82zym18SszWMhukGtOzRTYvTdZ+aj4+JvkINb5o4w
         4TRTlCMrFxkpcgPtD4jqGfJGDI5Nh117FK0Mqx1DHSPxKg8nE5EqliMPRtqVbtkgl/IC
         IdRymrplX9mKC7xFkYrV00aB1DTPpQR7wBoiXm6X74ZFmKkWANdhRZcWPMtb+xQmc3IF
         KUEF40Jbt3pN/ObM/ZIZQIoczz3gh0gsh4yypVs3Ee9cuNnCYZ5vNtwEEJ0mfRz2TM9q
         rvPzL5Lc7s0oeW1LsRI31fUO8haVC+iMfBHJJECdnezS0GxuTfvqeRHDJchRQX1wwK5l
         ZSSQ==
X-Forwarded-Encrypted: i=1; AFNElJ99Iiytdh8fp0pOmHyWzSh8i7k47PlnvPBrQ14nMMsvSIomERADS18wj51TwgEiotEmI92rECuch+w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFYfCYvWew3XUpOlZRNp7YV4+rnPyYrvji16g84LSIV3OZtIgP
	8V5o9WpdCJ2R5xwkIR+iIxNDDuId/EkQin+klcINY4FRjda3SMpuzBoQkL5lSdrhAr3Ie5hrWhJ
	QXXaDsiuF1374EFW7a1Qe+o9JZnPWBEStHaJ4FDq6sgdLMU4sTTTIp3K9pFV5INA=
X-Gm-Gg: Acq92OFxigivB60KadIkDapAmUVpe52Joh+zzzRJDGLm4+yCCbmN2m3Qf8XFHVqTkVX
	rb+UPAMezAbJj7pSM0lM+aT1xnvUEJq03ryxRsy8ydyNOp14CWx8eaWxfavtZqs5yCCrfeyn47z
	Tr2ZCTk2q2hX6V2iZHKpGyR6oPt7a1pwA6M1B25cu/GV7IsMeEggno/NMhCxRV45lyRhTUKP1rt
	2ccQUH8Z3zkwud8eunbaxNtx2OoXb5zebDqlvXu55gIeIbjuTVGt2rQORsx32ypHiOzV5z/7R5J
	qOADHOQz2SEaiYN3TKUTsJ6ebpsUsLwxSBmfFlCLdxBeobMETv4bobU5ukWvrCa39uXMfeno24m
	P0lUVnLGu1V41blgFKzxmBShm+GxYfvhLZyFEgaWHNQpPxZrik3F0diFhP/Wzdtw=
X-Received: by 2002:a17:903:244d:b0:2bf:800:19f8 with SMTP id d9443c01a7336-2c1e7e500eamr172872155ad.17.1780944209009;
        Mon, 08 Jun 2026 11:43:29 -0700 (PDT)
X-Received: by 2002:a17:903:244d:b0:2bf:800:19f8 with SMTP id d9443c01a7336-2c1e7e500eamr172871105ad.17.1780944207411;
        Mon, 08 Jun 2026 11:43:27 -0700 (PDT)
Received: from [192.168.1.10] ([182.65.158.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16649fcdfsm245047595ad.78.2026.06.08.11.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 11:43:26 -0700 (PDT)
Message-ID: <11c2d639-d2b8-487f-b627-f507bab25d60@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 00:13:01 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to seven
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com>
 <20260521-shikra_crypto_changse-v1-4-0154cc9cc0de@oss.qualcomm.com>
 <20260530-spiffy-glittering-quail-dff199@quoll>
 <289a5bca-5491-4fc2-92d9-1102aa664021@oss.qualcomm.com>
 <f9a88104-9292-4cef-af48-58a722194b4a@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <f9a88104-9292-4cef-af48-58a722194b4a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sOAG3lm2OpzGcEeFU8yejcfga5zqf1WZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDE3NSBTYWx0ZWRfX6xqESA+K+m0O
 oRLddi60p+ONU2+Ie3X3+aZi2Sz60I/FtpiIrVndLoAoq5HhVE51IxfrD77yuzyAtVfvsueid0U
 m7xTVx09UIw5STRlr6AeojyUOwXO3iInK0x1qNRp4Ci5BmYTP5c7o3EbK++xXkXiwq8EP+AxOHE
 ORvJZCk5x6wOQK0/CpvmmUsGh0fv3NMa6KIJeWetVpNQ2TZc9UVVFIiTw7EJW3NekeESK1f2ur+
 M7zTwArZH9HV2SErIF9mqcwfji4jNOkcg+Z1akbFnxLAmDUajZr3T5OdtFrNSDphpwmp2GP5b/v
 L8TSnciUYQCAqkq1vp59OeYDz6boxkQ4lMcQwfH2WS7zuvBUqZswS9nE9cNmYF/MowgVZ0HmM77
 ISX0r+QTqFA8ClCfqxW/D6l1tPRCLUquA2Li4jLuFEKH2Tk7xbMU4pozPlUBgVnaZ96uZu9i9ze
 bzOf2PJH0OzFJ44hleg==
X-Authority-Analysis: v=2.4 cv=XKAAjwhE c=1 sm=1 tr=0 ts=6a270d52 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=wKfY90lum8W+SP9crs9F8A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=gEfo2CItAAAA:8 a=3IJvv1DdaQ7zVQMhPnMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-GUID: sOAG3lm2OpzGcEeFU8yejcfga5zqf1WZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080175
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[18];
	TAGGED_FROM(0.00)[bounces-11338-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:vkoul@kernel.org,m:thara.gopinath@gmail.com,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:harshal.dev@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,m:tharagopinath@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,kernel.org,gmail.com,oss.qualcomm.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,devicetree.org:url,qualcomm.com:dkim,vger.kernel.org:from_smtp];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 13441659D18

On 07-06-2026 13:43, Krzysztof Kozlowski wrote:
> On 06/06/2026 22:59, Kuldeep Singh wrote:
>> On 30-05-2026 16:09, Krzysztof Kozlowski wrote:
>>> On Thu, May 21, 2026 at 06:47:11PM +0530, Kuldeep Singh wrote:
>>>> Shikra bam dma engine support 7 iommu entries and not 6.
>>>> Increase maxItems property for iommus to pass dtbs_check errors.
>>>
>>> What errors? There is no Shikra in upstream so how could we have errors?
>> dt-bindings updates are prerequisites for the DT changes of ice,rng, qce
>> and hence updated bindings in patch [1-4]/5.
>> Also, the commit message mention about shikra and DT change is also in
>> same series.
>>
>> I hope this clarifies.
> 
> No. Please explain what errors we see now.
I need to improve my commit message a bit.

Since, shikra defines 7 iommus entry and bindings say 6, observe below
error.
dma-controller@1b04000 (qcom,bam-v1.7.4): iommus: [[31, 132, 17], [31,
134, 17], [31, 146, 0], [31, 148, 17], [31, 150, 17], [31, 152, 1], [31,
159, 0]] is too long
	from schema $id: http://devicetree.org/schemas/dma/qcom,bam-dma.yaml

I am attempting to update bindings firstly by increasing iommus maxItems
as a preparatory step so as to introduce qualcomm crypto DT cleanly
later with no errors.

-- 
Regards
Kuldeep


