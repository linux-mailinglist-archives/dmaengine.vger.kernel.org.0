Return-Path: <dmaengine+bounces-12474-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pe0WGIgFVmqXyAAAu9opvQ
	(envelope-from <dmaengine+bounces-12474-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 11:46:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D97B375309F
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 11:46:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZogzCITA;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b="gLy1sJt/";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12474-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12474-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71BC03102528
	for <lists+dmaengine@lfdr.de>; Tue, 14 Jul 2026 09:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3883E43FD23;
	Tue, 14 Jul 2026 09:40:50 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B8143FD04
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 09:40:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022049; cv=none; b=J1Q/2mmmbvoNq/+Bmfd+SbxSlMP25/Bhk+aX7noH3CM3lyst6tS+djBaa0elYyRuiOfAZAg7SG3SKxAyeg8E91Dh9ArCCJAyXOW0T1VldLAohEIFIbTtHD/CnntinwzrQer5uZn3iWOtGUSFQhKgB3Z5DAzv/9J4SMEVLvWI6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022049; c=relaxed/simple;
	bh=4uVlRLOB2Dz2ou/g2e0sj8ArDYM9B8BpWIoR8yhRqos=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K8Um5KkkJCEH5DxKrimBcZxC1OXoZk42/LVFy0j9MCulkXmLb2Ukv4fcM9WEpziV/4hbZEWzbrn/a6CAWE4rSLA4ci/L7EsFL5COtvDxwrxOU0Yns+I7H5kAtQ507G4P79uM1XsFQoozQ6U7B7QL8UOBHeU/wMj4dbUI3HqTVsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZogzCITA; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gLy1sJt/; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66E6SSib3743624
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 09:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9WmUzQ33MErj9lXDVH3MM2QRZKZngI8rpWpc6ys6++4=; b=ZogzCITAYjBl50RR
	IzoyMdMx7TJwj/U4yfgyiK3575WU78YkfPZNLsPdjL9y5Q07VPk0jumgDCO6F7Z9
	DwHP7P6bd6YIZVP6EoUvDmhJmJ2aB8yS6/uqCepFHIUFMJabbsKB6gvCywo1zpG9
	/K35sQrK2r+OyEjQIf7BsYxKtT5pw4k8NrQIUX3olKpVQe+PzEyaDd7IzdZrDaC/
	Sf9Bgn9gk+YU1fsnVEB8Ts/rXxxXkL65BrEofMqHg59PBbZijy9prZW/s7VsGBLz
	ftrwkxf9D+pA2JOT0xviWbn94VxeDo6t7T/b8C6YmtNt08sfPnd4SIyOsZxNr9CN
	FpglMQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fd44p31qh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 09:40:45 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2ccd1958e8fso11075315ad.2
        for <dmaengine@vger.kernel.org>; Tue, 14 Jul 2026 02:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784022045; x=1784626845; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9WmUzQ33MErj9lXDVH3MM2QRZKZngI8rpWpc6ys6++4=;
        b=gLy1sJt/K1JtIgs3xqi/UO2yeRkgpZJrJ0VmZZsSjQFljhf9TQzQT2EPqESCLHX4rX
         TLUbfOer84YjSYhC0TZyb7RbxHFaL+tXuIWBWVDXYQGXLvYJpOEVIVi1LLDg3L6pN7nv
         6YATN3LjXcaifuCxlmjAMAFW4rMuXX4t262W0GKQ2NJ4v71uXCjzXdXEwbU30tniw/4F
         5VhxMEtT7v4me2PwX+th51f/37yKZ1CAQdm7KIiMZ/DzYQ/GgvIcrP1l9vJrI6bnnksu
         VjnAum3jh6iuXmWVODWYcQh8nHexStMfggmJX4PG6wuisCrkDwSBQZqBS+l6XIYsIAKY
         FNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784022045; x=1784626845;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9WmUzQ33MErj9lXDVH3MM2QRZKZngI8rpWpc6ys6++4=;
        b=Sbum1t38WYS7RiruO2bzlTZMjIxsHZXuG8HMqPmy7dnn4Gv+y/iegg149v6pXwhNHe
         dHjnUbZGyGgOBY2r8O4E1W608xh1qZ7oRURZ2/DHxCtTvOx1/1WKBMKW4I8RNIRxjqyD
         BGu/Qw10sCHrcelJBzL4fz3BdPn+nMKxwT+vMVnx3FvprmOXntqcTzsCqeYTG5qhMOgF
         cAa/HqJo6i2KSn1GWypg7jFvGJ6YZuSEsxWeuf7Aatb0sFyYLvIfLhvFbmudfqFr+vXD
         5i9kIF/nOv9N88VUZJndfHgRDEXuQt4syZkzeP5e35vyk/pRxJYRyiEMy+AeooSC4qF2
         BB+A==
X-Forwarded-Encrypted: i=1; AHgh+RpOi1M9HTddS8XvyeH+IQahAoehvVXiyxfOMavn8JYoqQTGxGY1KVjG7jlnvKdo8ZFdtTO4MhBPKHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaRGAOLgLcBTr2+6Vn5uPGifbY1qY3K/vWXjzgt5oZK8cNkP72
	ako3IM6GPp6jn2zz6ms3VbmFR3XTehQmO8kOLQtQ7ArtWK9z+p17brDhid3KZwGGEIaeXJxTkQ9
	bIv3BVh5YhkRtu1BHu+osbgxrV1h7zJll+qCqscCjWPco1Mxv0KT53sjVHB0T6fE=
X-Gm-Gg: AfdE7cki3GVsAPM1WmQ/Q5zgWtRmbZLEzzAa4S1QKSQlbl1GqgFotslbk/8cmSpGGQp
	+CAVgbEF+XySGKPKQxTRfA3X8ITgp8dtEemmw+7w60L9oG8f5cRI0eOo2UJe8bw4xniRVIDPCSH
	c4zV3szX9nfVsNje7BiueZQdzm9PPnh0Pcr/YnGGV5GMLMmE1vaNamB5BGkgdQxaEneCRnRqrnq
	EKu8M6hoK2qHpeEKPNSOQA9bBDtP5PIOUIEpIbB2Gog/rEXPhSfcH2A0es8/QQa2duGJqg5foR3
	m6iaXIpfm7Awolju8q7oarRHYPo6fl4MZsmrSxsqxTMURPGIW+94vLUYf1ZT5rUXqN4fCgKleM3
	aSNPRAPDSk9VYYFX8CZG5GH0c/lTVqtBzkireAnJf6w==
X-Received: by 2002:a17:903:15c3:b0:2cc:777f:d67c with SMTP id d9443c01a7336-2ce9e99be82mr125379055ad.13.1784022045007;
        Tue, 14 Jul 2026 02:40:45 -0700 (PDT)
X-Received: by 2002:a17:903:15c3:b0:2cc:777f:d67c with SMTP id d9443c01a7336-2ce9e99be82mr125378715ad.13.1784022044490;
        Tue, 14 Jul 2026 02:40:44 -0700 (PDT)
Received: from [10.218.31.125] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1edb0sm112560315ad.53.2026.07.14.02.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2026 02:40:44 -0700 (PDT)
Message-ID: <3942cbf8-62ac-4bdd-8fa7-fac6e121d5e2@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 15:10:35 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: crypto: qcom,inline-crypto-engine:
 Fix legacy/new SoC strictness split
From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
References: <20260706-b4-shikra_crypto_changse-v3-0-23b4c2054227@oss.qualcomm.com>
 <20260706-b4-shikra_crypto_changse-v3-1-23b4c2054227@oss.qualcomm.com>
 <20260708-splendid-outrageous-saluki-aa52f5@quoll>
 <d9b63658-b588-4103-a247-cdd78910a89c@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d9b63658-b588-4103-a247-cdd78910a89c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwMCBTYWx0ZWRfX3O71o046J3HQ
 33SJPOdzR6S0J7/7yrqR8yEd72l7tukcqVV6uRlH+ejzI5Bn5q5Vd6/JjprewzufethU1luPfY6
 0ipsp5h+jt4/yfqEO41L7+5cdciSaX8=
X-Proofpoint-GUID: XzTw6vGDBif6nLifHHinr-AxLwGt4DkD
X-Proofpoint-ORIG-GUID: XzTw6vGDBif6nLifHHinr-AxLwGt4DkD
X-Authority-Analysis: v=2.4 cv=BZroFLt2 c=1 sm=1 tr=0 ts=6a56041d cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=f0zYKoChvmPFgximC2kA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwMCBTYWx0ZWRfXy+K4nUuD+Qja
 1svzGRl4+/PxGuPXbMm6RLDFALOCywp6Lbp6YqhXmYw5FfIN2ypL9yZEeRnNVIVdWKDg6NfwX18
 nnPDyVIezPg6dPHxc8laFFLAPxdehqlXxa5OLcMXhx1tOA/czyAkYlCahhw/ZiPSaK1cM97FDLC
 X8rVt6CQtjV5tWCAIT5N1zO5uTNjGIM9iN9pjwPeTgE8oJngaUuXS/q4n2ohyuvqN6qE7e2ZJVZ
 WAKuc37MghdUZ5Ht/xXopw+/bNZrLv0X89bzFds7TUSZPv23L3g6bzUPVnXGnzjdjcopKSuXiyX
 Dyp5fZhhj6dkZfM9vq6pPnYU4G+eemBGD0g9pdwzXSxpFVHOzFcZfWRMZP7/QeGuE8Z80B12rE3
 k/7qr6k53POKEjvs6LbE6joshG7M5FYAlXqrnkJtImfgSWzw3E1s2SgEB1KDXtp1EheWUS7w7e8
 +QTHgJbKZBSoZXMK77g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140100
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12474-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:from_mime,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,vger.kernel.org:from_smtp,qualcomm.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[kuldeep.singh@oss.qualcomm.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:krzk@kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:andersson@kernel.org,m:harshal.dev@oss.qualcomm.com,m:vkoul@kernel.org,m:brgl@kernel.org,m:konradybcio@kernel.org,m:Frank.Li@kernel.org,m:agross@kernel.org,m:krzysztof.kozlowski@oss.qualcomm.com,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: D97B375309F

>> To re-iterate: You change the ABI for Hawi, this must be expressed and
>> explained why.
> 
> Ohh I see, hawi is different case(compared to milos/eliza) where
> bindings define the compatible but somehow was relaxed(got missed
> probably) from 2 clocks recommendation.
> Just hawi compatible is defined but no DT entry is present actually.
> 
>> I do not see any change in commit msg (listing "new SoC"
>> is not what I meant is not relevant here - it even suggests like
>> everything is here done without impact).

Hi Krzysztof,

It seems Herbert picked bindings patches of hawi/maili/nord and they are
now part of 2 clocks list.
This means there's no special case of hawi now and current change will
remain intact.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/crypto/qcom,inline-crypto-engine.yaml#n60

Next rev just require rebasing. I'll do and post that.

-- 
Regards
Kuldeep


