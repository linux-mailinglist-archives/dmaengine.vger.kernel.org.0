Return-Path: <dmaengine+bounces-10501-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIHtDYuxCmpx5wQAu9opvQ
	(envelope-from <dmaengine+bounces-10501-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 08:28:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D59AF566AEF
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 08:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C07301951E
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 06:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AF43DEAD5;
	Mon, 18 May 2026 06:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GM4wmrr5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TlntIq+v"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C03DDDD2
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 06:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779085589; cv=none; b=qWVNIWlnQlczy4cyiPQb0sEI5CTcKOtsbXNLe6nnp4gE1QHf1H+MbVz5sBo6Erj/vqsqVnS15oePCapSNDWvuNHZDr0HgmcjyLJPrAUrw58u2qFzWVdHqDb44rNEAB5oxRQd73cZr89BFs4vKjXuFYROPkh0GHSYtP04JmfX1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779085589; c=relaxed/simple;
	bh=jjz3Y+pL9ioG4LyZO0SNtKu6JxBaKciVZAOTIOeDNJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBjl6M9a/p/0wMcxDrIlIohTlQ5i9ZaoE2K1j7ByOUDwgTKbx7NeZdQHyr8ZuwpD0t6H+WyksY7M5hz0+TCrp6or9yI9Eayuc7nYHiRx/YH0oHjQ5BfArHCIJiD+Wc4CcsO4sZeFx2opQym2x+eQ5929JDNtNqRqdPsc+sXs3LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GM4wmrr5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TlntIq+v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64HLttNe4172509
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 06:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LJx5ROeCjQxor4dcHhUL14+iMhM743IgRkZgfrNQ0Zw=; b=GM4wmrr5/358OIyZ
	pBVTNkpy1Uqs1SIjv/+EsoaIwhurKA4f+YJNGOLjji/yc+WGYKzeZud3VJGIwVnJ
	3pkc3GbxCOx+SWrL14+UTCEdxtZYBGlHbKOmZU0BVqb7M6tQ44Xhf1rV1HgpgR7h
	YgBTDjR74qmG9x4bNBsepObGY/d/S4RNwhyenXGr9KvwL4lvp6gc4i5WK0mw2CZZ
	Af3ZE5++MS6cwikoj2Y5UYUHj6X70Z6RhIjIATRQ38RLYPRwShqbfvcEOlDCrL9h
	1CevsaXGoNtginyJ8yp2wAiGhGZ3yoJohnJw62SJp8IpmfRD4a8AAA6N3OU61+g+
	UyxA4A==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6h0g4x2x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 18 May 2026 06:26:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ba15e384c7so13349485ad.3
        for <dmaengine@vger.kernel.org>; Sun, 17 May 2026 23:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779085584; x=1779690384; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJx5ROeCjQxor4dcHhUL14+iMhM743IgRkZgfrNQ0Zw=;
        b=TlntIq+vFZnZwhLic5QYi0/dN2n5KoIgQaPBlBJIol7troxW5BRJJZoD/efwVFLTtG
         YzogtLb+WbM1UsYegPQ6HsNoq+KYmWd9fj2Q4oyJK1m2Q1WK/elsJZzv3Y90gpavA9CN
         DSwZ3fxEVbk2T4I3d/dKlcy2BChp/PCuPYTPbG9xDSVZiB35JxIgEKKWSEjcOg71OF2f
         Bt499hFI/PtKq7cFjyWVONxXCE+TO+WuHBgqUcXp+3gqhUKvX+opPex0GWghb7okWKd5
         w+83FEKn42G/FQFVGeCHYJ6hXaQENdQW4I/HTJdt4aCeooQ2tsdBYTxR6ahLekNY5tTa
         NxNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779085584; x=1779690384;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LJx5ROeCjQxor4dcHhUL14+iMhM743IgRkZgfrNQ0Zw=;
        b=Jhun+HlATBhoGGfd+ovEezx+QUKzsCl/NKFLmH2drcVCQS9idkABagrYl/9AlScT7T
         AN8pTtIEMoMowGhHiiqL6F3PyYB6AN+fN09Q1R2uWYRWDBCKNIy6pv6Q24qHn824hC9S
         K+rzwHERVUwAulg2Ja6566xCldqCMj6rpop3FWezdj/oPmHTGdZv9MLGrBLowKv+l2oD
         oMhrHni1W9eaPV1jFdUaNK9mgcQa7h29WTep2O3w3vdjb3cqXLQ85lZ+SOg1DCqX1mtV
         a0C3ri3HH0KD4PxK8KRmhZ6vqpsu1ntNF0hS5Ih8c+LI9AievWvukD88UUFlKp5lut9u
         sc2w==
X-Forwarded-Encrypted: i=1; AFNElJ895w+osS4GhksV/zZKxaah/QT89DtTrNrgE5BpRpQI6yEXF5MdDFAerhs9sMhgayPK94YIQLkHlKs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+w1LPa+R8LPWXRdLMqvgi+CDAhJQdIYZrIv++v6xbuSSRjy66
	Pvgrik1cqE3W0WSCJ4jXSMuklU7+msPmTm6VyhXfY0bfvfx3pOFxj5erIbTvePVE1N/lRJKdjfi
	G8rc67q+GDXYA/1jflR+7VVZzeAKxCff6R48+LF+a2fyNDT6w9GbvZirdwWh9Alo=
X-Gm-Gg: Acq92OFUFXRqd2hO9GogPzljjAsGHs84yyFmit7XnpYsCyudCAPciqcZX4QqQXLfoUy
	pPidXOkTBvMAKvKwRxgyODUfVB7MErlrzJ6SDbO/o+uyXkTSZtjP/BYYBBSP3Ki0nzpf2B5tuxd
	8GmALINezB9l7xbWThMx74PCJ5gDqVAV2DTTzq6TA1MgtqfVXUG+abSospdSh8XJCJOjPdo9m3k
	hjEVhPfNghM6wJgWo3wTxb8tozRRZsX7L9bUB7Qle0WjE7O9bl//gaH/PYVjGVvBduywRXpHzBM
	X+PvuXqAF2iODvlGaGjc6Pj8J9ADmGcea5Krj7lYGc2+LXCd0I+SrXN54xZIFPXd45xmScub5du
	coRPG48lS3Djd4QeZoyHhXQz7oTmKP41zsubAoMMaqsYRdIMV2DU=
X-Received: by 2002:a17:903:2b03:b0:2bd:9da9:a29b with SMTP id d9443c01a7336-2bd9da9a3a9mr100296845ad.5.1779085584217;
        Sun, 17 May 2026 23:26:24 -0700 (PDT)
X-Received: by 2002:a17:903:2b03:b0:2bd:9da9:a29b with SMTP id d9443c01a7336-2bd9da9a3a9mr100296565ad.5.1779085583727;
        Sun, 17 May 2026 23:26:23 -0700 (PDT)
Received: from [10.218.19.63] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d0fbc05sm134371195ad.57.2026.05.17.23.26.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2026 23:26:23 -0700 (PDT)
Message-ID: <d68ea0df-f275-4b9f-9fc2-154d76517135@oss.qualcomm.com>
Date: Mon, 18 May 2026 11:56:17 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: dma: qcom,bam-dma: Document BAM
 v2.0.0 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Arun Neelakantam <aneelaka@qti.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260514-knp_qce-v2-0-890e3372eef8@oss.qualcomm.com>
 <20260514-knp_qce-v2-1-890e3372eef8@oss.qualcomm.com>
 <20260515-prompt-determined-ape-943cdb@quoll>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260515-prompt-determined-ape-943cdb@quoll>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDA1OSBTYWx0ZWRfXx/JVTHihCvR8
 lPW8rT2CqUEJvXPpir9BABwCOsMxDN1BPQlaS31HfrweKgpbY9/fhe0VkDJCOsQLdnQepMXby+z
 to4ft4v6x15uGVvLy1xb/JmPP5wJPfELWHgU+t9jZbAQdyCHygjN0WxJlRrm2Rlh4NM4cTsaS9b
 8TXpjbed2cpGTx8Gjh4ND7F2ZOTiABsnsmJ3SUl+Fn64k1tVYk5zqMZuYuQI+rqCKBXSTcXIBTt
 a1d1ua3QFUFRgAlYu3X3yf84zf8T5ZdypmRgfOdwe+pcrX4UqS7lttRMI6qjmf4cNpspowQL5bm
 4OAMTXPtgM+i4bKtrtmMPkPPfmYdEK6jNRhURqu1dhB2arL1zuEUIn7ouUjpIT95fI9x/qrmJB5
 206o3dRQwz8PeusJkcEX+UcjtyffV0EIp7eCexlOzGh1Z5NcIzFcIHW+HNtothIfNxOQQinEQE8
 oSSMxshdxaWLnN+jFrA==
X-Authority-Analysis: v=2.4 cv=W7gIkxWk c=1 sm=1 tr=0 ts=6a0ab110 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=P5E9getwEY79pbPPo3QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: o_wU7BjzFsP6YfFx7uPB76mDsMfMBndw
X-Proofpoint-ORIG-GUID: o_wU7BjzFsP6YfFx7uPB76mDsMfMBndw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_01,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180059
X-Rspamd-Queue-Id: D59AF566AEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10501-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On 15-05-2026 12:23, Krzysztof Kozlowski wrote:
> On Thu, May 14, 2026 at 12:22:20AM +0530, Kuldeep Singh wrote:
>> Document compatible string for bam v2.0.0 version found on kaanapali.
>> BAM v2.0.0 differs from the earlier v1.7.X revision in terms of register
>> layout and offsets, requiring a distinct compatible for correct hardware
>> description.
>>
>> Also add a new example for BAM v2.0.0 to illustrate a more complete
>> configuration than the existing v1.4 example. The new example covers
>> 64-bit address and size cells, IOMMU bindings and execution
>> environment–related properties required on newer platforms.
>>
>> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
> 
> I am not going to repeat my comments.

Hi Krzysztof,
As per last discussion,
https://lore.kernel.org/linux-arm-msm/2d79d1b6-be1f-45ad-b673-c8b3b57f1e15@kernel.org/

Intention was to improve commit message on showcasing v2.0.0 diff with
existing v1.7.X versions and also what extra the new example is
covering. I hope i mentioned it clearly in v2 commit message.

May i know what extra information you are looking?
This helps in aligning ourself and incorporate all relevant feedback.
-- 
Regards
Kuldeep


