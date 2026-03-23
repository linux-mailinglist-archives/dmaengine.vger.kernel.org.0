Return-Path: <dmaengine+bounces-9605-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOI1DNBfwWmaSgQAu9opvQ
	(envelope-from <dmaengine+bounces-9605-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:44:16 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A4F2F6CE6
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 16:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 35D05314B63B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 15:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E9D3C455F;
	Mon, 23 Mar 2026 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pa+3xmrY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HDky20dv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978083C3C1D
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279063; cv=none; b=CiwwqdZ2UwLrZLwC7exXudCBXwpD+pNAQxIxHfaBNgZV3kDfQI1RKQphxACAWhZjrLsXh4HWPlI8cKmp+ozm93tDqZuc/TlGoXKg+LRmCqJBOh2dpuuilmL84nPiX0HJQ0SjaBKHs7t6Mo9lI3T3tdf/4jB4aG+S0onz19kS87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279063; c=relaxed/simple;
	bh=D/DbbvsYNV6WfJJN+Y3qtsfzsdueJP3Q7cdgK44aCk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dYRg1bgyaVto5BlMLRuDTPVWjpvjLQyAr3ZFzzVJ3ED7LqtVm/OmJvNCO+BaMgWyif+cgRdAK/Vyvp5hUMCjqbC3jIJmAXibDFDaCZzArLZSFlNbvukxvU+61+hf4949VgH+/r7ay1UCl/dHHOwP+oWLJmB4/B6zOz5a5odW+ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pa+3xmrY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HDky20dv; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NFGRIt3474215
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=; b=pa+3xmrYIo39UDIg
	YLcBiQ4lG5KDMC6Ply1GiYnsIn6X2qjP7K0CpJjtUWT/5ItlObDcONIXXt87lS9E
	GZBKDOPlcWhPbJhqixzJbg+m93+kJFA2CzQjB6P0zMTuh8GbCVQF8Z4WKTv5jH0U
	4wHLO5rl0QBl0ojaGoKZUWWvuVFWWqZl9qWfU0G6huxwd2jOpIiHCn30tMx2FuUE
	ZnKRXkPChYu4bi9ka/0L66JW0iN1n5DfMRLG/sQc4tH5FcRnxrL0t4pZTicHNItv
	x8GG9/1c01QXAbd4Gjp3kUSgVviCRqdscyw2g/UQsQxgqWu15AdsKsPUb8lxiMqA
	9/rDpA==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d355w0puy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 15:17:41 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-94ea6fdbd28so25571039241.3
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774279061; x=1774883861; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=;
        b=HDky20dvcXBjXsQFM+Y+e2SRJndV5cTP0GV47ePULtcgYYb249PM286/LzqccSlYJ/
         yYcZjyKFwaqRPi5AwFleeoV04pqDiwQqa7q1+HJwWUhnbUf8e/TNOhLRJiK35q7iDUJG
         VhzaHpvdwnz4l4ztIKGjAMZCHdx1n11eUmuP3haTTf+Z7P9BrJBpLwT1jLyJvOfsrbjr
         2LkcuixyKtUT1GJ/BieG4gY5mUEle6dzHkJ49uNkkiIVgTZHfkXurZ2pHpUX352Uw49+
         12HIiDvgJNJVIrFRJboNKDUOJ4X0zrrzuYO5SX4wWVCjnClTIcG8LLk7THmtGr3Avrxt
         TWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279061; x=1774883861;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=;
        b=ZzNB+20LDZ47D3qn9ERfPYwTa8rW9992poBm6zJCLclV0e5g/uATSpQ5KMfOfrPgnt
         jakvZs+ggiP2y+WksGtkLXa0QmqHYizx92hGeWOS8i8mMvQ3luq8hKLuEQ6l9asrTbI0
         JBaYL6adsf6pX6EKuQInZ5n1xV/NScodmxsGuLEPe26po5p9ufWOrHMHLsklEIb2xkxo
         WbHwW89UCcgMcHDaIrTfexSGxrkiBzS9XErgYTqeunAe54TPFibWxioYciHFnDJNlNA4
         u4i3cJMZH5LLxigrIOV/7LVVaAuaoj579u3qyuiaNSlJng5NExRMjZlZD8RATe/Nk8v4
         b8jw==
X-Gm-Message-State: AOJu0Yx7IIHT0fiFxF/YD8OO9o2yCg0lZt/N8MYh+3OHYtDbapbjx1Mj
	loG9UrR06IC797Gl2L2tGWbbnDjFg5uN+21kwbOVU8GlJitgNUHTfL8nA/7HtCRFoeAtMEbuNEP
	FZki+JuHfQrXy371/FyZb2O8lRUHceqFsHoi64oOistcGizXMTpNYoba9jdW5r1tb/LfOMEo=
X-Gm-Gg: ATEYQzzhr7dy/DUtCVi8ZVgMJV0U5TwMTCR2yrq6L/osnlBDZw2ZL7KuLdbPkf/Wq0B
	82fsyOO7HY4aHoAuCsq96ksSUWpF7fltojmR1zkm1KtuxwAD8JFVNG5idp7ZnwgAfXFteaCYuq7
	WJnpefcMtftWerwVIYvp8BfwZSQCbTczz/IMJQagBafePXIToCzdpIXkLPkVYu3YB5jzkUgI28p
	zlVFXCHlo1BPx9T6EmpGN6Q72QnTQ/lZEOUJ5LJIo1yH0khVfaXzK1j0bFwh+143NKHfym0/5RF
	IFTN9qCpB+7eXe65gwTzMwDJopPAmcelbD9oYKBcidm7C9WTupEVUfJGOtDd0XqM6HNC6wPHcy+
	5Ualvn92Mf8aQmFwKRtLF2bjTvCqFDqspCVRNcYGP8qaMI2FypEus
X-Received: by 2002:a05:6122:8c24:b0:56a:f34d:f225 with SMTP id 71dfb90a1353d-56cde3fb2e1mr6327695e0c.11.1774279061024;
        Mon, 23 Mar 2026 08:17:41 -0700 (PDT)
X-Received: by 2002:a05:6122:8c24:b0:56a:f34d:f225 with SMTP id 71dfb90a1353d-56cde3fb2e1mr6327634e0c.11.1774279060589;
        Mon, 23 Mar 2026 08:17:40 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:f9a0:d7e2:7eb6:79b5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644bd923sm35936993f8f.12.2026.03.23.08.17.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:17:39 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 23 Mar 2026 16:17:12 +0100
Subject: [PATCH v14 06/12] crypto: qce - Include algapi.h in the core.h
 header
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-qcom-qce-cmd-descr-v14-6-f323af411274@oss.qualcomm.com>
References: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
In-Reply-To: <20260323-qcom-qce-cmd-descr-v14-0-f323af411274@oss.qualcomm.com>
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
        Michal Simek <michal.simek@amd.com>, Frank Li <Frank.Li@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        brgl@kernel.org, Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=SMWOwwGJxSzHnqJ7yBoaojvGxwV6GTuJEaiwl2WXaqU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpwVmAhu8moplJ8pqXHH4fRnifztUVhJgIpoChw
 kDtIV7AXb2JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCacFZgAAKCRAFnS7L/zaE
 w0AeEACXfpNMwOBQHUkchG/Va8chbPZrXTY4ipRIK/aTbAWlxOQ2Ml7MmhfkppYmbI0hHBwF0QG
 9J+852i2qW02O8aKYUnxOwuTC+fLIY2U0HA8cSyeKCmyLJQDaeDdYwK+++aKJeSEiFywL6IciQ+
 iSA36P0m71JcKImO7/VckqewAKtw3r3uOKZTCagqfP/hlci9AaKW9r2MADqyAG+n3i3/vQ437b2
 nhU05VqpsCf58iDutx/z1uHGaBkP17ZPKIdOJg8FZUAT/b48xysNigp64CxcE3VZ5EJBSTKqkOt
 XhJLH+6TYbnSvHsCh5t4WY58EEQz6nVqSWI6VdSoOX4b3khVf95g9k9N2Kw3xSVtAoZiET5l5eB
 esPCo93MpEjJUjErK1cNMh7SIoPjj+kCqIrF3oE7LX7s0BAup2XGXGEB7naAQayD6Ap9EnUON2S
 ET2p/BO5DC7dWfWJlsmOV7/fZGVz30aVLDU0USWklTPzh1nd9ChJJCgtO8FJZzd0xgFMkE3c1VK
 8oH59LhVz6GsK2XZKkVblxwlafShxJU+qglU42SlIKpdIuzZ5t58y3OfcQDTgeK28ZXVaUcWl7g
 zlb2gQduJvKUWgTvt/mOESR6A0noJ4HKv4YFktEF3dK4RcvOEzH4LgkMy0oAZrf95F11N/23xEA
 RCjHrU7a7oekk8g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=fq7RpV4f c=1 sm=1 tr=0 ts=69c15995 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=rvG61WhHFVBzVmnuldcA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MDYKoD0zmY56j5c6JpK2XHBikr9X6oce
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDExOCBTYWx0ZWRfX6CEeafbdT/7m
 paIH4gl9OwrUPe+Sqzwk0DuwRi3eeQymbKUrcEW5wQzO7Sx7MWA/8Ob3VVYL/Ox8Q+XLt67kBTP
 AokOOvr18dzSLkOlDipEXZlV1BVv4HWNswI6zFipMotcWoOND9DKcnksBX6zOIvIJBTKnT2cl9n
 QhF32TjlWG7GAgVJ2dUXd24TBErrwOiVvNRrUm37TKoFoFwNhRMy1M1Wf2BVuo8rsO2WGZwWTe7
 CqC3X+a4JklA8nk6YwTPjWIrBc8rUTAa13Pnxd4aQGU74J0W60OPFgAcWFrF2f7rsSUw9ln72eG
 zXoBxzcWj85a3wC+FtE/pjA04HIeVbq84/iQ5nOcSKMIRZRQLqHt7YORhw7GZIVxV75xrh8xmjQ
 n6KmFdkhQeVo5xegNf4NKwqFUIduK+vs18OgLO4BPmgGXC3N6yH9SKSLhf0SQwHsk3f/G0M5NEK
 z4e7Tf+qh86CWzcZ8/Q==
X-Proofpoint-GUID: MDYKoD0zmY56j5c6JpK2XHBikr9X6oce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_04,2026-03-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230118
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9605-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C4A4F2F6CE6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The header defines a struct embedding struct crypto_queue whose size
needs to be known and which is defined in crypto/algapi.h. Move the
inclusion from core.c to core.h.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 1 -
 drivers/crypto/qce/core.h | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index b966f3365b7de8d2a8f6707397a34aa4facdc4ac..65205100c3df961ffaa4b7bc9e217e8d3e08ed57 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -13,7 +13,6 @@
 #include <linux/mod_devicetable.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
-#include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
 
 #include "core.h"
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index eb6fa7a8b64a81daf9ad5304a3ae4e5e597a70b8..f092ce2d3b04a936a37805c20ac5ba78d8fdd2df 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -8,6 +8,7 @@
 
 #include <linux/mutex.h>
 #include <linux/workqueue.h>
+#include <crypto/algapi.h>
 
 #include "dma.h"
 

-- 
2.47.3


