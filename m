Return-Path: <dmaengine+bounces-9863-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LJLJQSGzmnfoAYAu9opvQ
	(envelope-from <dmaengine+bounces-9863-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:06:44 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F7738B091
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 17:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4E7230D6FBB
	for <lists+dmaengine@lfdr.de>; Thu,  2 Apr 2026 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915C63F0AAB;
	Thu,  2 Apr 2026 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hhm/Q+Nj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RDqhAN7/"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD673EF651
	for <dmaengine@vger.kernel.org>; Thu,  2 Apr 2026 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141770; cv=none; b=tbyXotBFgQwOMw4JgNjU3HLBCRCqyrZqEKxsKYWlyq2xQhJqkgRfvLt4JLjlFlz5uxyrnpsvdIh677FXMxtXVeKaA8f9dUy893kTl7JjuywN8N/1BFx8sEB5s351gW0O3HwgvN0YrnrrO+rjFYqdOAuoDco5gWS+2jK622cww8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141770; c=relaxed/simple;
	bh=D/DbbvsYNV6WfJJN+Y3qtsfzsdueJP3Q7cdgK44aCk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DtGNWg1LC6UTPFIlcuNp6XUp4OAJsmIZ1ZejmjVGoOl7ARYrcTGmHcri5wD45/Ukot7+NgPZLHXNrj71qwAxZXjH48ufmk3tCtUpC6qY2ghfidPW1APgMsFJbI+8vXvfDSGEiLlOyh8q2hDRqe7Ztc92LF254gy/ycO/9oRrvek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hhm/Q+Nj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RDqhAN7/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 632BlMxa2338012
	for <dmaengine@vger.kernel.org>; Thu, 2 Apr 2026 14:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=; b=hhm/Q+NjHhrDco77
	6f8Ze5n4yZZP+l0GvEJS7/dD1ZPaYsAXrJTVWMwXuiE3+ebDLntYbEnTXgGrmDxn
	db4xD1p9lS0B/suY53jKBX9FlIVuUa44RcTAjubtXx5xZPU1CZg9NUlL7bZ6Bsm6
	nT+IH8JlCmug39KX4UPdpWlV0QoMWog+WoXL8nqbrjisPhCJIV2QcxIBVkU5BO6W
	XPw0mnxeOGunILCIdsLFHFsiKCDN9B7hzcjslY0xXoq8NzD3VDU1fIca0nHzEiYb
	HkmB1iRyRMhcvNB6/qagH4PNMLvLx/suZ2lAWWrmdEYV2MwvYvHbvsbodC+SmhwK
	vLWU8Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d9qw08sh7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 14:56:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5093787e2fdso37683451cf.2
        for <dmaengine@vger.kernel.org>; Thu, 02 Apr 2026 07:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775141763; x=1775746563; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=;
        b=RDqhAN7/hD0f6VW0rJkYEedhP5yy+BhTu5k+tOLrZpC++wvCqk9/B/9CanXmbe8jg0
         6gluEFXrdXM/n8+CHQhsIpjbr+4ivkwClA8RSRxR14zLUyoOrVfrlawXFyPsGMmCpLzw
         f1GmB2wpf+1SrswennxQtFUjvaD4lMzaz7BcYpL02yFA0LHtbrk3P0i295PIGWWbGRZ+
         mtvOVvQJo9SwZDsU57zQY7o9Pvwkm9jCLbTXFwMPDVNV2RkB9qm3eMEhZpXdGqbC1JaG
         +snuShu7AORJDXk0IChNHWCMpKxv5op1d0zzU4TFvryuQyo1SK0G6slvc4jyJOdK6YQ7
         GU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775141763; x=1775746563;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=;
        b=CTHnSmS1WgOfKYg0DTGM8CMaPE8XnpYFhvW9S2Qn8NjBAtp1w0wwCeKPaXUCNubT5F
         k9KEASE8wQgYZNndT0GBCwfwnKno6vg8vOJY/OeFI+KVbjSPF6Bufde1t/VODI0CAwA2
         jZxTmeMURAeaTCuRCAhJVe0y+nZ41+3vvY0Fb1MqYeCbWvbPnEM+kf7wMGZzQJBj8Llr
         VVUhEMBajB4CB+KwpEc94lb6CPk3tXCOxTr8LzSo01yCfw3uH15PByH4gPzYIoqY2FKf
         NC6jIwPxQaq/+d16Bk4A403HhTKuMSmQey39klJdKheGqZ8GJT+64DFVtbsSclE4VBzX
         4VBw==
X-Gm-Message-State: AOJu0YyjJz5LncCa6lhiQllo8ETh1d/FsMvYJR8h+zgJsWwLKhsbW/+n
	luzA2rCKIfz7VPSkGQj+PA0YZLG1xQz11cXiLYIKmGOAlxnR3GXRIA09K181iMpRLWy9dGJfdpP
	ni9GmpU4kVxS0+iD7wYc0l+yhsqFYz7VEVeA9c5K/42n9vgm+l86lOOZVvfuKc4s=
X-Gm-Gg: ATEYQzy3MF5upDqLip1xLVORU6OjNoUfJFoHnKcPr8VyB4/Xs07Bb2rE0M4Nx7+Q4sC
	UUOTJxIlSf9OnFcygvcYpyBhHOgNlnTLO+Tk2Rnwq269L92rS/ukhUxmN2TrHzKAaOQG4Z3Cp8E
	owDXl4wQZgbXkXwLGqR8JPLsAY5fCgQDDwjA4sO5KjlvrLZd5925ArbzXMQ60mkTr/nmc1bb4z2
	gpHkNyILn2Eg78jiD0RcvZIhgBM+HQXmHq8gkfHFD1YRqWdjPWiObV+W3W1eI+GTaTX84WlAzEb
	MTxB/pbyBw+XHmty3n7/b+Bqrk8QxDy2rvkGa1a52tBjVe1/AI7B4yvuNpXW1m+jUpQvZgzpo5S
	QCjTXDPB4d5S1rhJGLgxzyayt/Wgc5NaADz4yvHo6dbw7oaYLpgyC
X-Received: by 2002:ac8:584c:0:b0:50d:3a3d:425 with SMTP id d75a77b69052e-50d3bcee735mr111226151cf.50.1775141763251;
        Thu, 02 Apr 2026 07:56:03 -0700 (PDT)
X-Received: by 2002:ac8:584c:0:b0:50d:3a3d:425 with SMTP id d75a77b69052e-50d3bcee735mr111225641cf.50.1775141762799;
        Thu, 02 Apr 2026 07:56:02 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:4ff1:3e57:22ec:dadc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4f5294sm7234038f8f.35.2026.04.02.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 07:56:02 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 02 Apr 2026 16:55:17 +0200
Subject: [PATCH v15 06/12] crypto: qce - Include algapi.h in the core.h
 header
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260402-qcom-qce-cmd-descr-v15-6-98b5361f7ed7@oss.qualcomm.com>
References: <20260402-qcom-qce-cmd-descr-v15-0-98b5361f7ed7@oss.qualcomm.com>
In-Reply-To: <20260402-qcom-qce-cmd-descr-v15-0-98b5361f7ed7@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBpzoNxGfIiDAsunI8yEQv2dTMgafI9KDud+u6uY
 Z9EOTwuZLCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCac6DcQAKCRAFnS7L/zaE
 w6oxD/9yby24fgmJblPwc+DaP6ygv8XanMom0FqM2s+v228aXwkVpuyN5FBuNWQCeGnbjlX/ZaY
 4YrJNNmnLEUh+QqJGWauvTQRl4zWc085RXGDYn3P1kC2rrXBrmDgRMGrVbtJbnkvXRIcEzuSBzQ
 MQUM4/UDW9HjMTWjw8fHLfCU7KZoWJemyyV7XK5Kla3GkPuOcTs8NGIsi25vIfZKYLDXp6fGBMZ
 j1bQgZSFTRxq/ko1u/x5qywVyi7DX9x8EpLRUkoURrcPkb+6+lgB8DMYt5+dir3bsyTViQCB5yD
 J9vblBfKuB5z5E3EpHRASIfzKPcFcVY3IYXy8dX9Defg46axje2sP5/7SqMBpi+EvDiUj74rEXG
 NLxOpx20lwxV+xxdQM2jzJ1ND58pPgxE/X+bDj+CMB6zt6jrkbSeljO6fYNaZu6TUxTNIO6V2QT
 EsB6KXtMTdQCyUu6+RklRbDZRGhsGfovviFIODqy27D+0kICbdM/LSMX2zkf6wCIgEECBXXyGk3
 NI/nucGzvlZcNLQ/H9obOyWrEkOq89+G9kKbDayNxw2KPxMz6SMHcSpNWxrxOBoXwVnZpLUc7zT
 SshWVro1XoNq4nhzpOUst2ip+iJU/VefYxcClkUSN+xyIzHwFnGal/nFAwzhwTeQ4eWZrGTq9SG
 i+vVfSKWmwcYMcg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDEzNCBTYWx0ZWRfX625YwOCAgRxX
 NBiiPv8B+Q/0SlC+lR9ikrn1jKgogqqE3yLpHz3hVvcM/pCueNtjALh1rZq/twaUQwRiagQcHGf
 ST2SYCpKiMQJw0kBuX9YGBKihJk7ehiYO5c31srS43lOfPOWqr9hKAV0dpK9IAZSSYeMdCsGDfh
 GHLFZZvOdZwyU8N3w43+CGaGcXVw6RVnTbaSUh9i+uFFn1eIlTyHMCM3ZBNFwz+4fIsOG6FyTsg
 8hfb/TM0w6Gj55cUV/YcqxroveHVIgUSdJQFrlhu7Sbo8y4VzPtQo5BFS30yNgK2NvlBwFBGks/
 RZ0+9FXMMV0rydkDQvcrLs05cNoTA85q4ABgZChYShUoljp+odnzndYoJMNyc1zUQfkiiQAr6/8
 DYXrbZ/dSepwQn1U1vA+J75RSXi+vvqQ2cY5mnNiQxFusVpFxCGTotzz2V3g0hlxpVgL0I68Kze
 j656ziRt9yxtFF3WmXw==
X-Authority-Analysis: v=2.4 cv=PNICOPqC c=1 sm=1 tr=0 ts=69ce8383 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=rvG61WhHFVBzVmnuldcA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: WDgWnT5vbIKlo4lKWl4Hatg6bjEr0Q7R
X-Proofpoint-ORIG-GUID: WDgWnT5vbIKlo4lKWl4Hatg6bjEr0Q7R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_02,2026-04-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020134
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9863-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 30F7738B091
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


