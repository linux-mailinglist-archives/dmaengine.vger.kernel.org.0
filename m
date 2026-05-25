Return-Path: <dmaengine+bounces-10803-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIaKI8ngE2qzGwcAu9opvQ
	(envelope-from <dmaengine+bounces-10803-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:40:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 356FA5C5F99
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 07:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E46C93003812
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 05:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29D3E346AC0;
	Mon, 25 May 2026 05:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MPh+cISr";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VnVjeZCo"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D205333FE0A
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 05:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779687622; cv=none; b=R1vFdIAkEP3WY7RGZPdtelj663M+WIyrzun8qsAGnrhpvcAGNKvMdLSgWBP2zjjV8ZOs8jCRY6whFFn1wg5MOLh1vXd4GrXKPd1HjmAPoSpIQbJLp4iRuZnDwy2bcwXGkesXjoRYRVsES1VfCzUVsa6fpgUgUh1XVsXyL2JHJ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779687622; c=relaxed/simple;
	bh=322HUqGm2V5uAHAY4HVPW2OCLrCgUfPAfmZK7el/h3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e7h21U6p3r3Ws+OlExVBAU5yp/dc+7ZJ8Z3xb0LodqndDLwLUiS0xdfiHUnbdDS9QGKRIta/LOpKmqsasz7Rm+ljXFu6X6v7WYd4UH2/rf0wCqp8IT7If/7r/GDxEbIzy3nTU8nZE+NRY/ejPyaokrhubP35jl1boDoFonPkvYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MPh+cISr; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VnVjeZCo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64OJG44X2490773
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 05:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NXyCF+63V5r+f0I4sStSinPp8hUa1E+pxAtR+monLhk=; b=MPh+cISra0DFqIEr
	QcC/HI0lzz1WvVFDuFENE8MS5/xxDzHsAaLuV+JDloXFrR+KDvAxTqb9zYpp76Ov
	PnyGa4WkI35XD1ziGV4VK01i+xwodBQVz6VIjavYvjTiOmnIloUV2GR24ClYehuw
	MrJS3ZND7BgIKyCSv7bNjkCmybfLOB8ekZjzRaL3+oCOh44orgEHlANVC20i4b+X
	ENWqetDAkqeTg4KufCTFMcgSfNG3N4WWBgRPyfLv+TvIZINQ342mEbuTUxFHFiF0
	cWHvv30QV/fTpsgSnPsDw+kuXEpFZwViz9DPvbFMIsYaFvaajaqd+IX51KjFfOow
	RMuBDA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eb50fw0cq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 05:40:20 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b9b8137828so94151585ad.0
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 22:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779687619; x=1780292419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NXyCF+63V5r+f0I4sStSinPp8hUa1E+pxAtR+monLhk=;
        b=VnVjeZCoXrGmN6s1HwPZA/nf2rHHK/NYV31JVwXbbZxoF76CPyGE/2C62mttw0ctos
         CvarpvQDBD8GjkaaZqIKcViMdb3cNh341YFbiRdm3CVK6PryNJjkXCIDl57YWM3iB5D0
         569W2cyl1BhIZvmuVsYJZ6ZTuTmSvx+6Gik6+MZ9TzP6pu9Z4YUNXPieI5hqZlcI4ZMw
         ktzgj+ouew3ApnLdiWfMei4mOT5PBmv9XPA5VJC2uh6ZNArcTKfsXZ/sUTJonZgrOCOJ
         HNhjnW8CywTax8w/MYsyyvdNsV5aVtnEY+CEfyUG4tF572Amh45bciuP0Ol9IF6OHNVb
         huUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779687619; x=1780292419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NXyCF+63V5r+f0I4sStSinPp8hUa1E+pxAtR+monLhk=;
        b=fK8EV/dwuXEmI8cFDELGXn3+SN306ZjzwBrw/m8oO2QM3xZcgMv3eA+NJYkujI5oEL
         dqTqyiGEk6lqa2UltLzVHhLbcpNbzWUuASjuaQHY1OnTsRdD1m0pmTqtUHdCUcQzKnyr
         4F/yiiVLcwXC2nvohvx15M7hcXzezQ3vIENlSRdYghecccXJnSBWfQXm2BPsqF/7v8wM
         pDcz8+nfbarKZnjv44VW5uIPpLuvkzPNxTmqbcmDLI1OsjofhJwvMLpi7Ja35gZH1WaH
         GlMREKSAR4J27DHuNSQKS//F0MyExldPwRUxGKKSHN9qKAukmD0/qM8kyHs3sQe28pfY
         NG9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+mSjjCZ+Sfpivoaj9iAs8TyLqSpdr0eolpTIqhl7XBVe4rVZmfYekF8ayMN309OfcO/VBhu8IpsPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiwQYC881sAqqCFb9NxpN4lFr2BuOig8KLAsh4qFtcgdCgj96i
	5iCHjMsBWACXn4g9w4v37cxQgliTqAMdWglJO1qWUix1BrbTulvi8zGVgwoWwWnwDyKAggPLUn1
	JVKuJRgYX6ULrj3uG3iZ8zBGib3G0LZPyHWOisyArqQEV1oDkZbCj4velftqT1ZI=
X-Gm-Gg: Acq92OGICMfDD1vMMQajeklWyeMtT0vT95y2QClAEorDoRCMuCDxarSxwGW1lBFXmrm
	vwTkKvOOqhkeBxAtRtyny0YYxEYOE0eKNJcvvENz45Fd7baWaDWfs/O2+45xRDBIIEskHahFRfb
	mCcqerXBugGDQcvHaDPleqvtNmQoOKo9YL/XEPj+vZkseOL8unR2ZZ2PYc/SfvusrSMI9w98PZR
	EO8fOZeqfazu4vyRy8SGhXpXAelL9qN/gFjHK+2DoeBIfmxtc/1ACSV49Kb+QkpD8vsHW1GDIn2
	sOt2zcatNc4mwhzS6uh6giQKDvD/azmwhRKJ3ko2hj0W+lzcGUFCHBg9xfe4EAnb0pMMe0v5T89
	9ZPDABB2gj81rPMBxp6Sba9cyA5IMHh0/H/2osoyR+56I6+hb6UXy
X-Received: by 2002:a17:903:3508:b0:2bd:9a28:7189 with SMTP id d9443c01a7336-2beb05a2183mr142763265ad.7.1779687619325;
        Sun, 24 May 2026 22:40:19 -0700 (PDT)
X-Received: by 2002:a17:903:3508:b0:2bd:9a28:7189 with SMTP id d9443c01a7336-2beb05a2183mr142762835ad.7.1779687618798;
        Sun, 24 May 2026 22:40:18 -0700 (PDT)
Received: from [10.217.223.47] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb56ce4easm78073875ad.30.2026.05.24.22.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 22:40:18 -0700 (PDT)
Message-ID: <c1697372-54ec-4f57-85d9-ad375ff1a44d@oss.qualcomm.com>
Date: Mon, 25 May 2026 11:10:10 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for qcrypto on shikra
To: Eric Biggers <ebiggers@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>,
        Neeraj Soni <neeraj.soni@oss.qualcomm.com>
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
 <20260514194735.GA1939213@google.com>
 <d4d35e17-84fa-4c95-9bfb-abfd25ea7f4a@oss.qualcomm.com>
 <20260522024912.GC5937@quark>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260522024912.GC5937@quark>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDA1MyBTYWx0ZWRfX8hHl5yc8K6yj
 eoDWaoDgrF+mfdt+81Pxzc70biMeseC9NDR5NedmY7SoDYz+rm5qfuzL/y3m+bcNeqVFnvc8x10
 X2Q8iC1ug0CrSjaqm7oPcvT03nfgjs1nBjHXcV5TuCIE1/wUy7YwK3lKRCLtq9CJdAqKibBVaIs
 8/qLke8mE0cj/O8Vs3PceJBA6Syk/BZGZT3hUMwO331WD0YWqsfb46D7kQDij4fAIZ5oWwH1sRR
 WL/nldJPftnFz0IwkMBWwpjsLV2AYWvKEEq15tXhdTlZxwoYYlDK9ymLq9AhreFCJqDfQGEX0Jr
 N2LJcwvhOaL4GT5N1iDynKLmqJygyn+7O1/6Hg4zkmK/qwkqB7apRp0s52bZ984NxgPpEmjFUx/
 LlQIQX8OWGAqEhuIhQGkhozSa3OhUjUn+obG74iIRMuzE0/+jj/s0zyaJdq6lu6qJrW3ZCzkv0b
 lqXcaCGe8LRZMuUR1NA==
X-Proofpoint-ORIG-GUID: _nYFONxJEvHt6KA1Oqjc02KeJVpyRiT-
X-Authority-Analysis: v=2.4 cv=UdBhjqSN c=1 sm=1 tr=0 ts=6a13e0c4 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B3VgOHK6KqkFhVQj6DQA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: _nYFONxJEvHt6KA1Oqjc02KeJVpyRiT-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250053
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,kernel.org,vger.kernel.org,oss.qualcomm.com];
	TAGGED_FROM(0.00)[bounces-10803-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 356FA5C5F99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> It sounds like you don't actually have an answer to my questions, then.
> 
> Performance tests (e.g.
> https://lore.kernel.org/r/20250615031807.GA81869@sol/) have clearly
> shown that this driver is an order of magnitude slower than the CPU.
> 
> This driver has historically been quite harmful.  People were using it
> accidentally and encountering very bad performance, as well as bugs such
> as crashes and filesystem hangs.  We fixed that by lowering its
> cra_priority.  But for the same reason, even when enabled on a platform,
> it's not actually used.  Linux would be better without this driver.
>

+Bartosz, Gaurav, Neeraj

Hi Eric,

GPCE is relevant in terms of providing hardware security.
There are multiple usecases coming up for example to handle DRM/secure
buffer usecases to improve overall throughput for secure content.

Regarding performance, it's currently slower compared to arm CE but
provides an edge by giving hardware security which is considered more
secure.

Btw, there's been performance improvement with new targets and we are
expecting to achieve far more better performance with new SoCs family.
Pakala:    GPCE - 550MBps, ARMv8 - 8GBps
Kaanapali: GPCE - 3GBps,   ARMv8 - 10GBps

Please note, there's almost 5x improvement in kaanapali compared to
pakala. Though overall is still slower compared to arm but as mentioned,
expecting better performance with hardware improvements as we progress.

Also, currently qce driver exhibit stability issues and that's what we
are putting effort in stabilizing the software on immediate basis.

There's parallel effort ongoing by Bartosz to introduce baseline for
secure buffer usecases.
https://lore.kernel.org/lkml/20260522-qcom-qce-cmd-descr-v18-0-99103926bafc@oss.qualcomm.com/
There's active development ongoing and i believe lowering cra_priority
for qce is fine as of now and can scale values once qce becomes
performance efficient.

Please share your thoughts. Thanks!

-- 
Regards
Kuldeep


