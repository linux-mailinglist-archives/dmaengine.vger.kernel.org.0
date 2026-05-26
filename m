Return-Path: <dmaengine+bounces-10951-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBCeDsydFWr9WgcAu9opvQ
	(envelope-from <dmaengine+bounces-10951-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:19:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 469315D6448
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 04B3F3019A08
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF9A3DDDBB;
	Tue, 26 May 2026 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cspD0rS6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WwXukAID"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF413FF1C7
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801107; cv=none; b=hfJN5WRFSsQw3l6H1J0eKHZVqNadD6roMrurLCHQ6MBedp4ivriMDsnxXDBLy9LbHqINztzSgn0tJR6lvbpJ09kF+UGZn6qrI22T0vFa0JECUDDrZL4p81ilnu8IgKRV/tCy/WY16x8Q2x8shdSV1viRopwMMt8bAW1TTHR3ecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801107; c=relaxed/simple;
	bh=haVTCoWg8OL+rLPtFm5RXGk1TNPHvQOhQxIunu3z1Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=btKKXcP2dlccpRJfsfg9ddjZFvRO2JjL4ayb7EpnPUullDFoh5+qstCCs3oKOt1AzNncnaQT1IaWFRLizs/3MEOkJms1mpyb+KKuDxJnnvLBQe7EAUv8/A1wHeo4DVonYZgARFR8sHxRiDpq9sKXjLP1w70t4eG/XEUIAmpHRi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cspD0rS6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WwXukAID; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsVi62882498
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	FYq1r0spQWHIRnEkazipWdL66tm0s91r38cl3E1vzGg=; b=cspD0rS6sTsjkg7u
	bfnpRSKD5iF0h0G7DucdneVgcRKFyG1NcCe56UvgrS0m3zfeUhmkoCx9EiPKsU7o
	0iQ6glcxxD2Z/JS7lRFH6XwLm/xO29Q/FrnWQXJiErOWc0IDwTX+xoLoK0TSIjh2
	hF3uzVEE6j0nsdJYODyPC+WMvUEQW4NAxZLJAPX3lxBk6wQ0HsB1TotzrSy0kuzj
	KkH1koxNG9gKKYk0gbLju5syns5Zk13N9sAb3/T+bHmS+Q4JHbZZmPcKqsWWnm4l
	+m6jlUoR21P2p0dmZSfZh/FGO/4QuJy6J/aOJpQkKFigYLweuxXPvWwpj4R+T2KP
	18DdKg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecqudc84y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:44 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-95fdb602477so3200073241.0
        for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 06:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779801103; x=1780405903; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FYq1r0spQWHIRnEkazipWdL66tm0s91r38cl3E1vzGg=;
        b=WwXukAIDiP/SOmc/+Y9p4JnA6ccJdAWPG2qQh5Pj0zyttj+AOMtlCFEi11vRGSOIIY
         99RZ7QAbTJq4lEBBQ0V97n5PtRhD/3wmP8GQgZeUDLTCwn93Lms4TwfxgbHOv3C6UrNe
         zTwuXncWmajY6Wxq8YkpVccSD04ZBAhTuUNkSamuUNPGl9lrk69y0DqtsXly/dZ3vCTC
         ska1caXrvJzk/FcqWpwmktprBkvu7jeNxMu0t9rlSOT2Vqr6ExBEWdfvq9BYNvl6et6p
         GLsidlDDy2OvolzpU3aPagBvLGJlObznitorPwAnCjFAyoXUc6zCxChai5OeJkibKCMh
         x/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801103; x=1780405903;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FYq1r0spQWHIRnEkazipWdL66tm0s91r38cl3E1vzGg=;
        b=gwsLPogX2uJ+Tidl/hSRyLnTttn8qrpH8R1YzeSD6D2FazrUt+cXHFU/AV1J3jTcTI
         apvtwAQli8IFEIVyMVaD3I9CJWBuiI6hOdb5MpsxrI36ckBvS3ku4lWcMxLAViKKEW0k
         qLDnLxvP5g6VylgZ+PpPHJtS+QC9iO7F0zcM6giiH4CN/D11Ma6B7n4bS6ypGqVBNh0F
         uiy0emDmjXuZm2mmske/xGnG2C0Mh0eGvloEwts7KsrRbLysLJXV8h6Z3VHG4ME+mhRI
         9ovMA43HeeJ70M8syVQ/hSujT40f3M3NawjYNzzFJq3t6AJr/PMlzw+8UvyB5Ru13ovN
         kvTg==
X-Gm-Message-State: AOJu0YzK11wLlE2SsjbUMDMs3EoaZdgUJsL4lMN7BvM8GkBVjfa/N0vl
	6Mh2runoEOYdD0847orqlD/NBAT3Xl3F2Vkjr8aBAcwpts63ZweCHSv8iy0oDbc9UpiUU1Peg1G
	RheYfxxfuhbWRxw/7Lvf6TbD+BLAtGQD5EFjLZoArdn2MpCg5fqpxtB9wARe4bDg=
X-Gm-Gg: Acq92OHlH0oOeUAo1XQTehgOHJlJrdyp21pzJWtD/goA4zt1PifVM8omSVVGBf6R5kU
	xN41LmWESZ4tg5ajegUxLjILJw7s/ckcTrpeFH+qWdj1sLXW5clKdvSTd5SBRAbCPHhsuEYw1gY
	JqH99gFgQdEOSOosyoqwRZWB9wJpSZOrgWA8qD/U+35FyFtAmJaRCKVvDMm5b7aA4rvsHZjHbuu
	p+3JYGJ9Op0SZg0XNMbwU6MbIYHJ3sAkbNeDNEplcY1J3I/uao+JI0cvUD48dBzNwqx0tyPZ74A
	xF6UM7mj9un0/OYQ2g+5Q3/us/xDDmYlApgo/VViaMCkrfXFG6rwjuIoLdRgUGhgAtj+KHLtC2u
	qib2dYc6oRZD74F8CIahEvYsuP2EcWIAhyP/uTb/ez5Lkcpz2m3E=
X-Received: by 2002:a67:f0c9:0:b0:6a2:b2a1:f16b with SMTP id ada2fe7eead31-6a2b2eedf2fmr838046137.16.1779801103297;
        Tue, 26 May 2026 06:11:43 -0700 (PDT)
X-Received: by 2002:a67:f0c9:0:b0:6a2:b2a1:f16b with SMTP id ada2fe7eead31-6a2b2eedf2fmr837981137.16.1779801102691;
        Tue, 26 May 2026 06:11:42 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:15ba:1d70:65ea:9578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm34259426f8f.30.2026.05.26.06.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:11:41 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:11:00 +0200
Subject: [PATCH v19 12/14] crypto: qce - Map crypto memory for DMA
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-qcom-qce-cmd-descr-v19-12-08472fdcbf4a@oss.qualcomm.com>
References: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
In-Reply-To: <20260526-qcom-qce-cmd-descr-v19-0-08472fdcbf4a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3111;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=zlCDdZs7gUpD6zwuSqo1JfGszglD6fOxI/qdoCA4A3w=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqFZvyxtIGKA2Vmr0u0AYd8STPeppQGty0OScL8
 8apQe7FnpeJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahWb8gAKCRAFnS7L/zaE
 w8m0D/4mgvjO7Uz6sv75n83/rB+J52BwnHz0D5oCdqHB6tP58aeaPBALp4NPIhjYp1WXa2XOZbV
 z6Z1/3qWhI1PW/7xICXkbEPQUw96HDBvKO5hLpECMk+fg2kAx8SWXYV1NgS802BqvBzfAarZdN4
 rTsUu9TU/KvL/rQ+WKevWktlM1IU5+Ap3ptONJbiH21u5xG2LgGj2XsK4mTplzGDjFboFYHwYSn
 w2MMA5EvcUnKPSD6y+aqDh8KJ8rcW8xpORzhh1PYIg7Dmha6dwOVmGS7Lkho6qi6f65tT9ypEcr
 1wELkDhoRJWUrm+sL7R8NiH4hC5pZLRlNoB8IVC1h8rlKaflRbJa0YmLKnGSvgd/A+42qdz+F9r
 O+qO/vh03yWvwvhStIw8IB5/udkss46ucIycYZYaAWnLdFxTbeQNUC+oE4yhVod6zOyswGg7WzH
 UtvOfVk+/Htqtw5izaR9dokS6e9q31ehyBpb89iuKiDgoSz7QFbORavNzL1Yq0rap9Rgtb4LKGJ
 hYzrZzssf3KeMoyp226WK1En3/hffY7I72gyELAm57obdyhduc6GH+3XUxh4o25h4WGhY+NytTq
 aCtYWqkTX180KClZYYVOcaCGF2ycGKJxhL9Fis5S/Nsul4huqMqU7foj7xdrrFyUB3iHv9Eyt7q
 2OPn93Ny9vBZ22Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: AS2UojrCSSe_AQHLmOyyt3B7RKm40DUx
X-Proofpoint-GUID: AS2UojrCSSe_AQHLmOyyt3B7RKm40DUx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExNCBTYWx0ZWRfX74zZBRz9+B1D
 7BMqKC4sZw29AezY1U0kjFDSiqk3M8p8Lq7LiAyIgTkvU5cbi5LLmyOxPwS8ith0zlW+zMcgDre
 CzSTbCzSev1DraOgvwvldESqZ8nZ4MpqLqzex8nXrQi8rwJEqqheEXzZozKJvNumurghLoeKXaV
 1ulwysKuFkfPbsw6MmABsv176YUMMgcsIciT4384XPVdcOl4JDz4TPKnMVxiUOVl3NZToVwtiiR
 thjKEBFLRKG5z1LgnX5gzkkE5llga2csZ3YT09l2ARZpAP03/DWmJte8S1vVirGelk1SBoy/XeS
 Ud3k+nciXxcU8dmxU4DUO0cmuNBRhMBKcLsXVqkv8nbfgI236UiXwRoW64t/rbcrDhDoEgY9ZFQ
 jxLDxK6WHMG1AyESh+ZVXeXVr1ig23aWsRGFEG7GiwWMskiCGbRzgw0YhlhxcSe6d4bkMzj2hAJ
 5BwZXDUwXvkQtokcInw==
X-Authority-Analysis: v=2.4 cv=C9jZDwP+ c=1 sm=1 tr=0 ts=6a159c10 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=KKAkSRfTAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=9tNk7rGwWxUH_P3zroIA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260114
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10951-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:email,qualcomm.com:dkim];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 469315D6448
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

As the first step in converting the driver to using DMA for register
I/O, let's map the crypto memory range.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 23 ++++++++++++++++++++++-
 drivers/crypto/qce/core.h |  6 ++++++
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index a0e2eadc3afd5f83e46724c8bc3e3690146b86ba..d7b7a3dda464964afe6a6893bb329d5bd5759dcd 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -192,10 +192,19 @@ static void qce_cancel_work(void *data)
 	cancel_work_sync(work);
 }
 
+static void qce_crypto_unmap_dma(void *data)
+{
+	struct qce_device *qce = data;
+
+	dma_unmap_resource(qce->dev, qce->base_dma, qce->dma_size,
+			   DMA_BIDIRECTIONAL, 0);
+}
+
 static int qce_crypto_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct qce_device *qce;
+	struct resource *res;
 	int ret;
 
 	qce = devm_kzalloc(dev, sizeof(*qce), GFP_KERNEL);
@@ -205,7 +214,7 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->dev = dev;
 	platform_set_drvdata(pdev, qce);
 
-	qce->base = devm_platform_ioremap_resource(pdev, 0);
+	qce->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
 	if (IS_ERR(qce->base))
 		return PTR_ERR(qce->base);
 
@@ -255,6 +264,18 @@ static int qce_crypto_probe(struct platform_device *pdev)
 	qce->async_req_enqueue = qce_async_request_enqueue;
 	qce->async_req_done = qce_async_request_done;
 
+	qce->dma_size = resource_size(res);
+	qce->base_dma = dma_map_resource(dev, res->start, qce->dma_size,
+					 DMA_BIDIRECTIONAL, 0);
+	qce->base_phys = res->start;
+	ret = dma_mapping_error(dev, qce->base_dma);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(qce->dev, qce_crypto_unmap_dma, qce);
+	if (ret)
+		return ret;
+
 	return devm_qce_register_algs(qce);
 }
 
diff --git a/drivers/crypto/qce/core.h b/drivers/crypto/qce/core.h
index f092ce2d3b04a936a37805c20ac5ba78d8fdd2df..a80e12eac6c87e5321cce16c56a4bf5003474ef0 100644
--- a/drivers/crypto/qce/core.h
+++ b/drivers/crypto/qce/core.h
@@ -27,6 +27,9 @@
  * @dma: pointer to dma data
  * @burst_size: the crypto burst size
  * @pipe_pair_id: which pipe pair id the device using
+ * @base_dma: base DMA address
+ * @base_phys: base physical address
+ * @dma_size: size of memory mapped for DMA
  * @async_req_enqueue: invoked by every algorithm to enqueue a request
  * @async_req_done: invoked by every algorithm to finish its request
  */
@@ -43,6 +46,9 @@ struct qce_device {
 	struct qce_dma_data dma;
 	int burst_size;
 	unsigned int pipe_pair_id;
+	dma_addr_t base_dma;
+	phys_addr_t base_phys;
+	size_t dma_size;
 	int (*async_req_enqueue)(struct qce_device *qce,
 				 struct crypto_async_request *req);
 	void (*async_req_done)(struct qce_device *qce, int ret);

-- 
2.47.3


