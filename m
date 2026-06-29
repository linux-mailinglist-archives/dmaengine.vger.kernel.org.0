Return-Path: <dmaengine+bounces-11840-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tz8YItZDQmpa3AkAu9opvQ
	(envelope-from <dmaengine+bounces-11840-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:07:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB26B6D8AAE
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 12:07:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=ZUmlEoEG;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=JqnEV8Gi;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11840-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11840-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7441F3059A6F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F4E3FBB44;
	Mon, 29 Jun 2026 10:01:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6D43F888A
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727294; cv=none; b=P6Rp/II15Jda5DH5GgSKIZUbhDdIZz6qknGjVC7wUYsF129Dhd3D7w6//9UhFNScmyc4U95yFiHGFcXCXNZ89A9SMp7E/dsZLg3YV8HaRyooHlds8tC5MWiKDU3lDV7Z0fsZkrsEkK9ZPY8c7YGErIA92m9OWRWogh5QQzQwNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727294; c=relaxed/simple;
	bh=wwQQXRM0gaMVWX/Dzgfr4bRQXhzRu9ojnjIrabYrXjE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sHvVv5dlDoop8p2ooITRsVg4pWVytXYycRfSEG7At8SHUU2a0qjfU2eNyt4kv2xp8jDidR1gBwzY/iI54jbfvpNLi22gq0r5fQY+YbuCbEp5IunkA/8VNNQs2tzMC5Vx0vCeml/J+xtRWTx6uwqevPT9Be4NCbTLOYrYZdSBB/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZUmlEoEG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JqnEV8Gi; arc=none smtp.client-ip=205.220.180.131
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65T8aPdK2368152
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bgcnvEi7Ugd3Hv4P87KEsVYA0DlID2yHzdzIugzgP4s=; b=ZUmlEoEG5NwU9itX
	YK1eHEQZHppVWzXbOKbDgG3nJIjOrHO/RGzGzW4n3sGtg14SKkR+Dawqkfgb5E9F
	d5mcERF0UZpL+7ODPMO4UWMpdboCQuJ2Sl0dMDy2DYh8d/Jc5l7TpskKV3O1DTbx
	VD5yRnjBJt2DR0+Q5hfKSVbmVavRRW/Tv86mn9MkPnWRAAccnL5QzBHoVLyq/sTu
	YwpvXeIfCtj2IWEiNLGbYNn0N/HBuNaD7j0+AhQGTvtDRn60HvlWuok9Qg2NqMoK
	Sm0maLwXWM2t5CKRukdGQ0CrpGuQ4icEB302l77b15AT2DAGQcZcMs7c/ngR8IyI
	lZ1apQ==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nbgrb91-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 10:01:32 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-48976713b46so3017377b6e.0
        for <dmaengine@vger.kernel.org>; Mon, 29 Jun 2026 03:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782727291; x=1783332091; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bgcnvEi7Ugd3Hv4P87KEsVYA0DlID2yHzdzIugzgP4s=;
        b=JqnEV8GiEc3sQuX4GE4BF1hdO8GHoZdjq8VrqSu/jdAt6qdDg5Pqj6JeAf38KAP5TW
         kXsx9oyUSftMXfd0C+ozmzTL2PSGKBaWPinweo1OnNCBjt6nOKKcXfqgx1UeabyoZUOB
         8sCyiDumwfZFOn95j5Krjl5TU4SpRq8CBUJbHHXVGGmarMEoRNZV8lOWs4ikTq/fLXtM
         KBAaT5T6NJPbXUPRTZImK5sLHxDMTvB/vBab7H6JW7itS2jg8BMdC27lugydyyga/YUP
         PEullvc2vguA8eXC0tNpRQkj3jHKLclzkC0CzIN0sYRL2bH6dVa2sgT+nhFUVf/6TEwO
         Dudg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727291; x=1783332091;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bgcnvEi7Ugd3Hv4P87KEsVYA0DlID2yHzdzIugzgP4s=;
        b=RxlToLjlVlMDpm4FyOmLQywIJVUfhrSb3FfMhI/O4rqGR0JOMIIl8T+xsv2sbera7b
         E2CXo3GlNLANe0T8C/bJh2nc73y/beVoMjzQoe3BF07GJdWli/+OXIHp7Zr6aqVtIV0W
         MNlQKrzwd3k0GxGD5C5N5Tq6bw0XTAnFPWA/JBD+Zl3BkpdWroUiIOXZ7N8Lxax213Ex
         JRC2Jlr/0gNk647UJIslrm+IesQFGYzesjutDzYG4TBubuTJ+0XkQ75UYgqwhRbVHQkA
         xOExg1aKNogRYqMz/fbo1IW589kcqeVUsGJnYMb1vNfi/VeYfErKFJfxrnuWmgLPslTX
         LbHw==
X-Gm-Message-State: AOJu0Yzy60Fua8XzqjEliU+YxbeBwoaQTj6FE/15ZGuc15xGzKPB+lcG
	z4YCUvD6XIR+jtxlu9452aJjah74QGHv1LDCkRiiPP0VuOZRF2x3NiFmhm4nhMif3l0u46dB6Ij
	2OK0BgNmeTISiybIb0X7LSaemTiiETbgc5VC8tMQP7xaPeqD6xQ5hV9x5eWuD6kE=
X-Gm-Gg: AfdE7ckiFQcybkS6O4CdHfMdEGxJKpudskJh6R+AU4/V0Y/YgD3fwRD8Ok4JGKE8sv+
	JHpkQSXY+vu6aGvOKS92ENKRp920fv4YqfSDZQwDCSu6TV2hat8D0xpSrTGW4uFNzzG33Q9XTmC
	nyLdKzRLEq9xMob+etZkDZsjwe6fsmpDM1UXkJnQIdNhr/WTW2hNOAaSFD2zFR1u+jHTTgUJ/Tc
	3ynUMU290K/mZ+h25U27rk7bHaRPCbhgoPD7LasbIaGW+XzNNLE5iSyJV5q1inaT9PLsRtdp5Af
	VxTCtLZiGZE+Vw6aDfC+dQSuo0Wvtk9Eh8nI1BjvEIYQ5fvKsCyxseYtzC7q+91aQUh9QazYSBj
	4bKM/chxgE8qsL/sXXgQTkW/roh51KA2T8eBOmKnX
X-Received: by 2002:a05:6808:c189:b0:490:a1df:b17e with SMTP id 5614622812f47-49218112e37mr15351326b6e.31.1782727291119;
        Mon, 29 Jun 2026 03:01:31 -0700 (PDT)
X-Received: by 2002:a05:6808:c189:b0:490:a1df:b17e with SMTP id 5614622812f47-49218112e37mr15351293b6e.31.1782727290728;
        Mon, 29 Jun 2026 03:01:30 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4640:d76a:6126:9b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4705f8ea729sm24729405f8f.0.2026.06.29.03.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 03:01:29 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 12:01:03 +0200
Subject: [PATCH v20 01/14] dmaengine: constify struct
 dma_descriptor_metadata_ops
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-qcom-qce-cmd-descr-v20-1-56f67da84c05@oss.qualcomm.com>
References: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
In-Reply-To: <20260629-qcom-qce-cmd-descr-v20-0-56f67da84c05@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>,
        Andy Gross <agross@codeaurora.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2295;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wwQQXRM0gaMVWX/Dzgfr4bRQXhzRu9ojnjIrabYrXjE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqQkJnL7OegSYxwesjK+cEVKpb3XLBwJVycyYXi
 aaBmx5iG3WJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakJCZwAKCRAFnS7L/zaE
 wzb8D/9vPQevfch3WxayUq7v0SUu5cwPXdZY019Aq7isOzzbiGYG5zcvmLNnQwXq+j9yGzqn3VG
 lTKhy70aktK6FeTk1a9GM3HDYDJ9DaFobSLCGrxBuP1ZHCz5je7yQFcz0L7H7WDFNoOYYX67cjg
 hqx+f9ZIBiTaFeDQU6Mqhc/cft47IwZxBpAhNvLSWatgmr3nzqH4SQM1x1pYLChA5Y0e/6zPo+4
 p7luhmuiuKxD9ogwGt9Bja7D8S+yesMRbF9aBivwp4Z0hTSHI0g1lKM04ROdHLyrKGAhl7i8HEN
 ZVqLq1RAOOwtm4rmjb9njODYRK+bWaIJhO+PR2rrGlV41tIo7FbjWaww9J2QOKYVK1XrLFUAT2K
 5Uzc9NBaNq7tA2LbDS9e/ViHPAGv96R2LGHgZ4DV2U6E5tPXSTknzPxHLpPdVZnWdjKK+YxDxAs
 s4KLJvKKmXzzO9mGv2ziFc7Z1SA8pObdfvIpiTS3IrglxBNF/wQrnMgn828W9l7niu1rgvZJf/Y
 PQwhKDDv+DPYCcX8CAwfNGnXdcDTWmYgrxwYxJ4W8fEL+CeQWaToNfoCH2Rp2zViVcUW0Zo4Ja5
 EhFCbcuPIhV06E6J78FR4OcHsm9XcvLdo3F83DrgaP3r4C0w8XiuZxzBhjlnofarvc5FWw6bI78
 qemDa0OHWgvYE1g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: csucG5EcNhfXrVvu0MoELyMh_e42I7lc
X-Authority-Analysis: v=2.4 cv=Z4Hc2nRA c=1 sm=1 tr=0 ts=6a42427c cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=XeVHrwws4l7kqE2Ex6IA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfX+/CjOlDZw8dX
 qVL2GFTpC4iGk+qgFr663KY4YpjgYaTS8O7OHrNqhVAEgHLAd4aCQ3nE/I/YwygceIFdjfbWS3j
 BFTpWilp9d/z9Mnol7tsxKfOY1Ob4e8=
X-Proofpoint-GUID: csucG5EcNhfXrVvu0MoELyMh_e42I7lc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDA4MCBTYWx0ZWRfXy56jrco8NkVU
 HU1CP+CWusjj1SFIHL2qVIZXYgfbhBR2naJ384a9DSYi7iT87tXrdU7XcND1OBYZHevIFma+umz
 k94chZQSVZZiBrOfBfxeUhwDQfV2tFaDZGNfLuTIAmg9FjOKwLq7ctil2Q060XWCNsIABAF4IBH
 obsaBWWIxbeg7nYwXAtZGh8SA7+BCEC82l264yzEahKlE3O3YnNAh3YgRK/IbKL5QQn5ximowZu
 noHpBEYsha/8x0kpgdpJ6Z1C/DwIluFnbeq9xHUsxLj21sv08Vk5DMpCOJ726zLYXGKZluhPpCp
 o5P7GWQtO3sxhOXVYidcI1rAnEl5/4SpiZuxKpl5UlW4jKqn1aK+WWz3EgWHgoMiAUOT2hUiWDN
 9urjdminrvrge4tDQnqCnm7kLKVYWcWznKBPzrjKlr5+Y3TYaM5nKRDoqt7zuEjsGH7R/njI5u4
 HrFR5/DOVVAm+jg/jkA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290080
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
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11840-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:corbet@lwn.net,m:thara.gopinath@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:quic_utiwari@quicinc.com,m:mdalam@qti.qualcomm.com,m:lumag@kernel.org,m:mani@kernel.org,m:stephan.gerhold@linaro.org,m:andersson@kernel.org,m:peter.ujfalusi@gmail.com,m:michal.simek@amd.com,m:Frank.Li@kernel.org,m:agross@codeaurora.org,m:neil.armstrong@linaro.org,m:dmaengine@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:brgl@kernel.org,m:bartosz.golaszewski@linaro.org,m:bartosz.golaszewski@oss.qualcomm.com,m:tharagopinath@gmail.com,m:peterujfalusi@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:from_mime];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB26B6D8AAE

There's no reason for the instances of this struct to be modifiable.
Constify the pointer in struct dma_async_tx_descriptor and all drivers
currently using it.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/dma/ti/k3-udma.c        | 2 +-
 drivers/dma/xilinx/xilinx_dma.c | 2 +-
 include/linux/dmaengine.h       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
index 1cf158eb7bdb541c4e7f4f79f65ab70be4311fad..fb21e0df5ab7b20e4e16777b5ff7f61d2ae67b2b 100644
--- a/drivers/dma/ti/k3-udma.c
+++ b/drivers/dma/ti/k3-udma.c
@@ -3408,7 +3408,7 @@ static int udma_set_metadata_len(struct dma_async_tx_descriptor *desc,
 	return 0;
 }
 
-static struct dma_descriptor_metadata_ops metadata_ops = {
+static const struct dma_descriptor_metadata_ops metadata_ops = {
 	.attach = udma_attach_metadata,
 	.get_ptr = udma_get_metadata_ptr,
 	.set_len = udma_set_metadata_len,
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 404235c1735384635597e88edc25c67c7d250647..165b11a7c776abc6a8d66d631e19da669644577d 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -653,7 +653,7 @@ static void *xilinx_dma_get_metadata_ptr(struct dma_async_tx_descriptor *tx,
 	return seg->hw.app;
 }
 
-static struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
+static const struct dma_descriptor_metadata_ops xilinx_dma_metadata_ops = {
 	.get_ptr = xilinx_dma_get_metadata_ptr,
 };
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b3d251c9734e95e1b75cf6763d4d2c3a1c6a9910..5244edb90e7e7510bf4460b6a74ee2a7f91c1ccc 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -623,7 +623,7 @@ struct dma_async_tx_descriptor {
 	void *callback_param;
 	struct dmaengine_unmap_data *unmap;
 	enum dma_desc_metadata_mode desc_metadata_mode;
-	struct dma_descriptor_metadata_ops *metadata_ops;
+	const struct dma_descriptor_metadata_ops *metadata_ops;
 #ifdef CONFIG_ASYNC_TX_ENABLE_CHANNEL_SWITCH
 	struct dma_async_tx_descriptor *next;
 	struct dma_async_tx_descriptor *parent;

-- 
2.47.3


