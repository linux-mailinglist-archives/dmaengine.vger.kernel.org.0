Return-Path: <dmaengine+bounces-12040-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EWcLJcc5S2qSNwEAu9opvQ
	(envelope-from <dmaengine+bounces-12040-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 07:14:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CF970C8A1
	for <lists+dmaengine@lfdr.de>; Mon, 06 Jul 2026 07:14:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b="oexoi/IK";
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=imRtolRn;
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12040-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-12040-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95B263006681
	for <lists+dmaengine@lfdr.de>; Mon,  6 Jul 2026 05:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4713BB66C;
	Mon,  6 Jul 2026 05:14:43 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD11B29BD8C
	for <dmaengine@vger.kernel.org>; Mon,  6 Jul 2026 05:14:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783314883; cv=none; b=SKmgEv7Y8HufSWN+hP7kyscS53VdeCPSG4OPSYwt3vtTOdaX0OcEaclXUP/Jo5akQt8sZ9skvS1r2SIZcchHEAIhG/OhJSQic3J7ZlfSLOe5K613HVAsvh8k5mW+Z9bihi4IWWxEEqujxbFvU9RBLg3hjOZTSeHn+aS3fKDTD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783314883; c=relaxed/simple;
	bh=43ten+Gz/F2+MVp56/Q5AodSmF6Ff70fegkfs3rK5Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QKUgd2Jr6aGcZLR9fpTegRENodGMea5TSt9mgbqcz2Y8fvsMaJUgHBGnM4gPSDkALibjkn1vFl1Z2FaPNCL1WfgPzSAeQGjDEMol7pXm4EQxT4eWTpfUfeGE/VMi2Y4AjZZMCUBfwC0l9/ObFspaYcu7kFuWmJz9zIXe2pW5iRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oexoi/IK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=imRtolRn; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66641Z6t3594598
	for <dmaengine@vger.kernel.org>; Mon, 6 Jul 2026 05:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kYIs6wSazNxueEfC5imZ+rnvShLGqCVrBmYh29toab0=; b=oexoi/IKfP1qRu5K
	BlcxNHcj210n77IvNeQKzmT6enZEjddXuJqiG8DNsbmPhr98QhwgIaQGc8i0gA32
	n+b+6aVuVc3neYXustu21UlWfWiQvr/60lQBybn3ykVb5PVRRZK9Qm9Z5pBUq/qA
	oTSWicaKasaXsHvk2CD/Xr0n+7SFdXgb7xmXHYZY4vb1YQMvXCXVMc9x9NGUY1Jw
	D33spxKjKh3W2zvVoPkKCtXRTfNf68RoOTn1H0LCXC/G6rDXoxxtjtc3oe0+c08T
	DNuRgpX6e3zQoiqk+HDtxVMlm/XbllGei6GY1wS+rj51I9B1eUvtVrTwLDCaIzkw
	QfQtiA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qvgvrc6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 06 Jul 2026 05:14:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-847ad67cc51so2551778b3a.3
        for <dmaengine@vger.kernel.org>; Sun, 05 Jul 2026 22:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783314880; x=1783919680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kYIs6wSazNxueEfC5imZ+rnvShLGqCVrBmYh29toab0=;
        b=imRtolRn/ILSsxiYCVNduscAn2eJv0H2FrX4qdusy24dvg5XeKDAwZ8cRSStofQajm
         7EH+635EO17FnaqP/N+y3XMAzmVOyRe8AcFg+pzyDvSkzAU7k95g4PeXqGm4nODtUlPf
         UBZqNts0ZC+1zaf8F+Ei4qr1C+ZvI5H2QgvnIpxHmYm7S5fmlDm35yVyXr1VqbrIrBu+
         fVCUjR7Ht0FZZROJ320CYWvpgli2e4kc3o3fP9W4ou1eyIvKMhkTg+0UrCZTBzzr4GYv
         L1V8JLlrpDBHVSKnLRP6V0fPntgx0jI66rWv4A5MRUmzWyu5cR/YReds5BhK4sVoWbMx
         T5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783314880; x=1783919680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kYIs6wSazNxueEfC5imZ+rnvShLGqCVrBmYh29toab0=;
        b=tNKi3gDVkHnwkYgNewZmYOj/4SAVa4SgIA2XY4NIV+MIyya07Q7Amf8svX7ggCQ8ai
         wlaEWbsdk3h90zs0lWxrZrWefmjVPsXUFWFTsoLZZhODP9+2YGZcwIwG+x0/trfMQTgC
         F6WGqQmU/2ueMrH4/THOfu4dxdmZGx0Xj4qO8cviIROaj0dB47hHM8RgWpVBhemzlS9g
         9T8ruZNJ/soSlKHJYk2SQsbNw317EL6zMXUzZYdqyBtpn3yic3pp7PC0l9FJC3ECcMh/
         afZTbjVIlF2NaBjy48tsaIGCTcAPAj1HQXCBIdf81F+78N1JcWgD/RepryXdkm5P7czh
         k8gg==
X-Forwarded-Encrypted: i=1; AHgh+Ro7FywglPlyXXwNCBZs7E3NbsR6w9Eo/1fKRc4OJGcfS4q5mUCIoBYUEoGxGyrZs9x56mCYPDqry+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyscPjhVs+myfSg8WrfXNxIhJxNDf8KRz7wuoalEOvpMLTxlemm
	sTySuGt+G3/qEX8wG5m+vhilWh9/VQI7B3fIaNNTKB0tdUG+mWfVykjSrLl4MBUL4ji6W1sYylN
	RZvbHV+a0E4ezRuVVswJ8YeVHu8Qw8k4BWfooI/ZFkRDpJnpzrZL9aoXHDDV9Rsc=
X-Gm-Gg: AfdE7ckMwiJdy9IdLc51tY7G9SbPA9ehUiZhbqlVixR9iqBPpx3Pj1of3433Zn/uFtX
	GYyysK37YqJsDt173vIHXVVoTgR/7WooGkwtN5UdRRo02Y6JGqvBBFASpwXQYg4AhtOti6pW0f2
	7GM/5XaSovYD/3k4qKlddRTo6ZYzrBmpA1cK/xA9GkxvPRwIBr/nb2hX4j+tfFKw6m7hTDW3Tp5
	zPu4eF/uXC99JjNSSyC8UweB/mmR/XfVjHgFA69zjvCGVkdzxwb8NZJTIZNpjCqE8PiZIMCwFdb
	lW7T/YH6tP5s7WeoAISmo0oQAWR5oMlICH4NizT8YEsQ/lThxK3JKk21XdL0MWXBeZtyWBcOMdL
	5Vo0gc8v45Qi8SBXLyFnf8bGsm6lxv3lYgCD7GXh2Vq0=
X-Received: by 2002:a05:6a00:4294:b0:847:9268:d73f with SMTP id d2e1a72fcca58-847f6d5dfd5mr7123201b3a.9.1783314880424;
        Sun, 05 Jul 2026 22:14:40 -0700 (PDT)
X-Received: by 2002:a05:6a00:4294:b0:847:9268:d73f with SMTP id d2e1a72fcca58-847f6d5dfd5mr7123182b3a.9.1783314879970;
        Sun, 05 Jul 2026 22:14:39 -0700 (PDT)
Received: from [10.217.222.146] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-847f6d4986bsm3015278b3a.29.2026.07.05.22.14.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2026 22:14:39 -0700 (PDT)
Message-ID: <ecc468fe-5c19-40db-8df7-4c57183cfae6@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 10:44:32 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] dt-bindings: dma: qcom,bam-dma: Increase iommus
 maxItems to seven
To: Krzysztof Kozlowski <krzk@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Harshal Dev <harshal.dev@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Konrad Dybcio
 <konradybcio@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260702-b4-shikra_crypto_changse-v2-0-66173f2f28b3@qti.qualcomm.com>
 <20260702-b4-shikra_crypto_changse-v2-5-66173f2f28b3@qti.qualcomm.com>
 <20260703-steadfast-greedy-seagull-ad32ab@quoll>
 <e53f9b7d-66f1-4922-ab20-f6e66015c912@oss.qualcomm.com>
 <0b182566-2a54-4e31-9a1e-40bdbb0f4a65@oss.qualcomm.com>
 <bb8f2283-93b6-4ea7-ada0-875778c89b3a@oss.qualcomm.com>
 <95251d7b-fcdb-40cf-aedd-a60773eb3136@kernel.org>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <95251d7b-fcdb-40cf-aedd-a60773eb3136@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VvoTxe2n c=1 sm=1 tr=0 ts=6a4b39c1 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=dAOp68QCQ5i3jAq88wQA:9 a=QEXdDO2ut3YA:10 a=QYH75iMubAgA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-ORIG-GUID: DJ7arqmyqGEDk9AZ96aXGJLx9DY7-MHN
X-Proofpoint-GUID: DJ7arqmyqGEDk9AZ96aXGJLx9DY7-MHN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDA0OSBTYWx0ZWRfX3x8vafbi1XJD
 IWfHrhxNG331r4CNRp+nisw5wuVryjR9kDxiwK386gH6KcMOjbUPlE7K1h0F9e5lqM2e122/f5Y
 ThsnqB/BpqwbT3yFb9DkZeXGQwGzPKY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDA0OSBTYWx0ZWRfX7ZF3TzIctHJI
 LJ6yW1QopC353GN5EBm41EosHiDaeXMdxax6KwUC1wpjbgOQvoTDNTCMbOTO8GBVVK8uabmXsTv
 BQa0zBfWPWF83YoD1WfVCnoLWTYJHptViWs1eg7drnHYRB0MJuC+GoBhcnH1goSt8lupJPomEqP
 Vj5PdMwxYnnPNzFiRbwQRWjwfduhNnzgaD2rXeM5cGvY+vTQ4C4kIMJBT84oaGGnbJKyz/zQfS+
 P6n8SRfDbOa3196lA415DX5QElY0U1mWzHq9lvsrEsR4fwjGCwvdHN11x9v80rU826F2BrpQzbt
 RAU45KmzcsTYAnpiGOJVGNrP0FV/GNaQfzN/yAZFL+SoB4dg+vUDEV+pX2zdAklZy0aCRJrfujc
 3cJuAP8gIq+KcDm7u0BDqK9LwuYjG1jiuGkWHueGmAIItYTDZWcNph2MmsyFDePNNzUabJ3RPYH
 uaulm6YXTbc5jwuQx7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_02,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060049
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12040-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:konrad.dybcio@oss.qualcomm.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25CF970C8A1

> From that answer you should have understood there are no warnings to be
> fixed, no warnings to be mentioned, so that commit msg should have been
> fixed.

Sorry for inconvenience, seems i misunderstood your comment.
Let me update patchset again and repost.

-- 
Regards
Kuldeep


