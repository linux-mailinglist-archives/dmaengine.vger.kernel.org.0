Return-Path: <dmaengine+bounces-11300-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Eou4LdKcJmolZwIAu9opvQ
	(envelope-from <dmaengine+bounces-11300-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 12:43:30 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4435F655436
	for <lists+dmaengine@lfdr.de>; Mon, 08 Jun 2026 12:43:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=REvkcG7N;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=h4gR9VzW;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11300-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11300-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 465D930391CD
	for <lists+dmaengine@lfdr.de>; Mon,  8 Jun 2026 10:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5946F3B47FA;
	Mon,  8 Jun 2026 10:35:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C193B47F1
	for <dmaengine@vger.kernel.org>; Mon,  8 Jun 2026 10:35:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780914936; cv=none; b=UZ+myJvRzi/l7nLHOclxTGZh9t7GG2igd5a66zAZj5GQVSP5wqOTjrEbVYl+8lIrulmwCb9kBhFEvW06jbr0zh0P4kRzzjTRL0LmpKL5kVwytayaaFc+bOusN7ZUDOEwO2e2MBLpXYq6iJRRwgvJkiNysvGru2bDf/3bDmL/zD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780914936; c=relaxed/simple;
	bh=FVM24WBqaMagISzpUGWgdhivHwLozYlEFzZscEEqlXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KSICBbV1HkcbadkhIVYrLibMnkwpVAtfb8lLQvh/Mp944jDFY+J3+DVveIR+G9vBeLlI4lA2HR3zwNPiPaOBay5WULXBDMHqInyiI8hKV5FKdXu6k3XP1BjtjomqXhzjsfVKr1/UXPbOwWuDp9kf34qrxz5GEhQyp6VK8tSI55c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=REvkcG7N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h4gR9VzW; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658A6cRY3274936
	for <dmaengine@vger.kernel.org>; Mon, 8 Jun 2026 10:35:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5JbEetsrM6ridwfrxye3mnM+0f/IzAN2T4I5PfdGCd8=; b=REvkcG7NvDiL94Kl
	bRqk6Oo/yEMlgz59r+gV3Ue3vYVah8ErnV/C6ckxOc8EnHkDCnPbgf621WXpZUlu
	zARNJlus6YhZ/ddBXiy/6Kks5UyOxf8nY1TaMQh+Sg2qtFxcAkBQr4uk0FO+lkdj
	aQhwMLHhbc/M3H6iCdnd4wVFcQ8LWWtt6Ge+MSDFZzeQ6wG4r4rqN6IFFVGWP9kS
	A+1tV0469nLgjFYcqEZCQqK2b4qd+wfdco6hS1XTtG/NInnooRDS3O3zruWcfIVM
	a0gPkiaNEUBbyi9qNhtdCksXX/9WvMBPfIdpjKyRbq66WbV31lBu5D//sEu685ZW
	nLsPGQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enuptg443-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 10:35:34 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0bf6904a6so58631655ad.1
        for <dmaengine@vger.kernel.org>; Mon, 08 Jun 2026 03:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780914933; x=1781519733; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JbEetsrM6ridwfrxye3mnM+0f/IzAN2T4I5PfdGCd8=;
        b=h4gR9VzW4WMNfGQVCRKOQotu+pnoq9AcXozkTriLqhE50F39wUQlG5qyuFsV77ZUVm
         iXA4FpPkY7Ch9g+TpkgOKG/7NdvJrFmkSwqgQBrjiH1sKBBCuvcD3h0ftQ4PHmCbyglE
         m8rsGUL9e1xGO00k8Hj+N5asHNmupGemCNLjvr+VtyeZKAdDX97vvsffZ9anh8el6IFU
         AXvzvCXFXfVO8rH68hE4vD+PHpFSpTwJzGVrfyqxYxDmU587Cg2nOOZT4MchTN47HP5B
         2DZ+YYaarggcut7HO5Tlb9tvdUMROD7iZw8cKBjgaZqb/FD6N/fElueqZrrmEhHe7Z0U
         E9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780914933; x=1781519733;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5JbEetsrM6ridwfrxye3mnM+0f/IzAN2T4I5PfdGCd8=;
        b=UWuQdjU//vIjWCJqCOXMSyo1HD/n0NC+sjjxoQaY1s47N2FZ0xfb/MfKumU9baVdL6
         cy+GSXTO8yJ99KnpSkLsz00NN0sv0OJcf6aDY7N1j9WQaNAMcdnwbz2dqzJRhkfJnqVY
         x3ZqzfZ68FE0yfCrN+ikgpadku8flM6HypbyEzT1cuOZ6+NVrpLeUXm9CisvGm8Wl5C9
         X5iZ87C5oGkg/2L/ou2xljaIgaX10VGdCilGRSWfd/o/ywwy3kGwJdMwMoG/KoVJ18Wv
         qU4yr24SoKGIjAztboBR18k+h8Sbif9K2InfpkGXaKVejeFKaNWuobP3XKZp//oHlq53
         GLcQ==
X-Forwarded-Encrypted: i=1; AFNElJ88Fq7BkbDiDu8Cfgz/lOgFaCQb0qqnunySjW2+ItCKVl7KDeE5rd7YMwbyi4VcX6UvBEwzNZMivy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHzJhBNadOZaSnpGqcskYfieThloBNh3hq3Mi4PkvtVVWz4gka
	XFTfxsXdXMBMI1cjY7wyyyKplHx4ytznburxxg2aabz63JrnazbHsAxYo6p2eH67FA/vMtD/eD7
	kpb1xR78qYPA7xaFGOBzELB50gxEdZ+xs7WxOw0hI5fSXqIhGwG+gfOA0XoknFqK2Wfq3L+Y=
X-Gm-Gg: Acq92OHVX8tYeDzsi2EKX1rRiCX2+MEDYc1m5IqWSvg2C/4B/kRZE6oi+J0IIXVt0zx
	Potp+FmziAs11EakBAJOovUeTz5w6VqrZD2OXc4xg+iw5yKLblo0KIy735pIRCtC/LGZqPKv+7Y
	fQQjwkdRjDYJdVakHV4V+AZ0udblPuSOcNLZQFeFF36qhpIg/F9mQhZR9JiE6xHpq+spEK96pxM
	RqVGjwaZ9PLCbzqQqZQP/6XM2f6yG7R/bG7xrkQhmPoqswUX5f8aH3WvWhhNpyBYU/xbEBko/Bp
	YaECRsMHIpyD3nmqDq4oSgvFg+V7KxOeBtvxQmVBIAabpBHUoNf9fQiSDeI3+oR0Ue1NDXNDoF6
	aTFtNIX/IE0Aa+wOLn/oV0o6JS6orX7wbO6bsdYjiD3iOkgRMkYhTp6kL9CJ3b3U=
X-Received: by 2002:a17:903:15c7:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2c1e78acf24mr169901045ad.0.1780914933141;
        Mon, 08 Jun 2026 03:35:33 -0700 (PDT)
X-Received: by 2002:a17:903:15c7:b0:2bf:dd0:c8b1 with SMTP id d9443c01a7336-2c1e78acf24mr169900775ad.0.1780914932684;
        Mon, 08 Jun 2026 03:35:32 -0700 (PDT)
Received: from [10.217.222.59] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c166396fa9sm177600475ad.66.2026.06.08.03.35.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 03:35:31 -0700 (PDT)
Message-ID: <fc0e48fc-0cbd-4f70-840e-674b29260a1c@oss.qualcomm.com>
Date: Mon, 8 Jun 2026 16:05:25 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Add support for qcrypto on shikra
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Andy Gross <agross@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org
References: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
Content-Language: en-US
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
In-Reply-To: <20260515-shikra_qcrypto-v1-0-80f07b345c29@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 2NWk7_vUGch5ClMJnPvar_ZR-4MDR56q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA5OSBTYWx0ZWRfX6yTKehESD0+L
 e5BQD8+9qO8ZozjA6EvQjgmrhy/PN7A/7Ti4KRh+yTYB6jncR3aBfiElbg6B1MXxYzQnXqu/pFG
 Wf2jhrttI5nCQyS8Q/767gXdOzVK60ZZmOfDMgR+SDxGHyJPVSuEQ0X9ZOUjb2imfXKmCyoQeEZ
 hWnLbMB4lCLbXizt1mKb4GnyR7BfB9kOQiUX8s4FP6YLAPLyTOoaFdFmGK1p+d3TRE/09pQl7iB
 NhqZdZ3z1D51DNp7IpTfL4K+OroGEmKJ0YAc604H/VKTUZ5YMjUm2UuB+uyNYpUoQiscC3FxXgY
 xCtxW50jjfYNSIA+ryP08XHePHZ2jYIKUT83CXrv1n/pzgDhjoSM/t69+SGsVBiXPXncltYvEyn
 AA+imgzAz2X5XpdMmII2lVUHZydwSaDorAyRdJoUDjalGvzTaC3jl365AuqqhzRyd7P02ztsS90
 3aS5fv9Xc/1hqbN86HA==
X-Authority-Analysis: v=2.4 cv=XKAAjwhE c=1 sm=1 tr=0 ts=6a269af6 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=B3AD-90MoOjFDUla1LkA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: 2NWk7_vUGch5ClMJnPvar_ZR-4MDR56q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_02,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080099
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11300-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,gondor.apana.org.au,davemloft.net,kernel.org];
	FORGED_RECIPIENTS(0.00)[m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:konradybcio@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:tharagopinath@gmail.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,qualcomm.com:email,qualcomm.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 4435F655436

On 15-05-2026 00:53, Kuldeep Singh wrote:
> Add qcrypto and cryptobam DT nodes for enabling qcrypto on kaanapali.
> Shikra bam dma supports 7 iommus so update dt-bindings accordingly.
> 
> The patchset depends on below. There's recursive dependency so referred
> to base DT patch here.
> - https://lore.kernel.org/all/20260512-shikra-dt-v1-0-716438330dd0@oss.qualcomm.com/
> 
> Validations:
> - make ARCH=arm64 DT_CHECKER_FLAGS=-m DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml dt_binding_check
> - make ARCH=arm64 qcom/shikra-cqs-evk.dtb CHECK_DTBS=1 DT_SCHEMA_FILES=Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml
> - cryptobam and crypto driver probe
> - kcapi test
> 
> Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

Kind reminder, rng/ice/qcrypto patchsets are sent together sometime back
in single series and please follow here[1] for discussions.

Please consider this series as inactive from merger point of view.
Can still use for already engaged discussion.

[1]
https://lore.kernel.org/all/20260521-shikra_crypto_changse-v1-0-0154cc9cc0de@oss.qualcomm.com/

-- 
Regards
Kuldeep


