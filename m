Return-Path: <dmaengine+bounces-9176-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKavA1e5pWmoFQAAu9opvQ
	(envelope-from <dmaengine+bounces-9176-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:22:47 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0679A1DCB65
	for <lists+dmaengine@lfdr.de>; Mon, 02 Mar 2026 17:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 528C0303A242
	for <lists+dmaengine@lfdr.de>; Mon,  2 Mar 2026 15:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645DE421887;
	Mon,  2 Mar 2026 15:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SBllgFz6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GRYo3eiq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1395841C0C8
	for <dmaengine@vger.kernel.org>; Mon,  2 Mar 2026 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772467062; cv=none; b=aMHj/0X3AA6zuB7P0VfumnjcGAOOqSOjNJm0qpG1kHejrto7/ISO8gT0Q7E95sdRVbiTjT2dP0NZ4D4E3g3ZCurinRbbKXZH0YCB3XM3ye4Rocnn4zxE8l8fef72D0nZ7WdLQLoDs87Ta3UH5+JKAv7IzVw7lovLoxth706x+s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772467062; c=relaxed/simple;
	bh=D/DbbvsYNV6WfJJN+Y3qtsfzsdueJP3Q7cdgK44aCk4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OzgKkQf8a5y8dRsU0xszAifJYzDGQQbtTt7U+rP4j/i5+dP60UVGpKdGsUJyxQn8eg9JYQL9QjabAIlivQGd/NmGLzqmkkSurJfcfPv88vOgNBEU+y5q8Fanb40p7i73Umg/CgziCWVnau579p/XvTONW41BzW+cz57Yxso4h9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SBllgFz6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GRYo3eiq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6229EwRN3630910
	for <dmaengine@vger.kernel.org>; Mon, 2 Mar 2026 15:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=; b=SBllgFz6RRZIhcTk
	Ovu6OJSriXhpnFIAcfKMJw1i/J3Db+QzABVLKRafiE1IbZWrDg4NHUqNrjA7lNrK
	AyezPrXWrAuZXainW2H5Y42tef0FKODWk9H5vHx+DPptzFfBc+GR1MXkgv1KJ4NS
	2ARW3hIZdFf0XxToG+oeM2qWDWJMdi9W+NOhFXILIMNfHes4+NS9OHveiEpR7Usn
	yq6Df3jmdOd0C+Nn5nNpgFdRwxZdhjmzoMDHnwyEPpa8Z0rzAORzNvv7DfCczp0s
	iKGijakEU+5qPOZP8FhzdzVxGg91cT6KzZhnGEN4Elap/cHHUhCbbng4LEcgovh0
	GS64IA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cn7rhsc8b-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 15:57:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8c70e610242so48900685a.2
        for <dmaengine@vger.kernel.org>; Mon, 02 Mar 2026 07:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772467059; x=1773071859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=;
        b=GRYo3eiqJxLRXkxitrukb4G0FUXi6oUabzpHMWF1MC/wLXzQnkI3f51cpcDvH3hx+Q
         1119A8+zX98PctGdbhZzyUDlLPQNZWIanHvEq257jKdOHk5oaGFZoJnMjRQL3xirEa+a
         B0RTNl15X8LfApj3kfqDZoZqU1aB338IhtynQVRzo6lOekQStSquocRdsjMrKVcPpSRT
         SVG0zirxWvRr0bVuHT3lhsjYGk20gcbyEjBB8ZKzWO9FEwpWPwcotLzSxNtVukj6W822
         HD3x1semrSQuKCP8D2gr0flD48tdCtzs6LGqtKqWT5eNToLgKC2P0mDZq+1YXOdUkTeW
         3MaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772467059; x=1773071859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f+eJOMoesWuzpXTSR4Li0Qt2PYtZi1rSvrjFdAlx9Tk=;
        b=COtwWTEEfZ5uI+uAcM32RkelMDzkLR13cPGipiOmblNNvj/UC2mLtKbroVCphJy1H+
         LLzXNYVUzGiJt09hSGBI3UsJRv0iluqqZfh98Anmd//0tXYisDTXZxSzAEXShI3z3Ncx
         JA4HDwBgI4gMfuPAxo+lyMMfSVfMmA7lZ7fAnmKUrAmLiIWPXEaRLOPHLcGnO40/wM4F
         tF3uKtrj90s+WaiNQ04WvsMDFFJFDp3z4GkV4gyWlRdl2Ct3bL6PRqMQbmYRQVLVmQEu
         vQRY8MhQ/bml6dgojC8r1TQXy/cZWjnKgl32KmR9sLBbyKd3bSF10XfKbPJMarNqUrWI
         vRDA==
X-Gm-Message-State: AOJu0Yyr7P+gmXLsPbq7PbTv33pI4zMLchmfkVk4AJqm9mFWinHg6wKH
	d75nCxywNSOBCvzFfi9wC+2XWU3V3Udo93fQwyJ56OG3j66T+E4ZwiMN1mLeP0ZpmSpvSmsgrv3
	ZJGQtyEvJKT5ymKiJ56jV3XlTa7onpk0PLRAnmxAbccSFCf8dTLpukNp/0FUW/nU=
X-Gm-Gg: ATEYQzyaG40OL/gtkZFC32XZ+JgZsuC21SOXgnykeFLbG6ePfFw5ImAOw+1toRGQSgC
	uXdUQFELV+ej7gn3S52KavqmnFkarUKBVIc+ta84exRYxQEgAFo1yDgG71czwH+Jn3wjeuePb1b
	GI8UFSqQk6n+bf0c/8m5zCvIg3/wjowPrmcXlukprfjO0uK1KHwyPM+ErlwSiUzYUDsbDw089xN
	T+nc/nft7yAjaya/3obM39cOj8I4FqyOFXOrP6MYcvO8wcytFKWDqAv7CWEGI1ExGAf/I0caPw4
	lKcAbe3I01AjYjgIm0VN1mSOqwFbMkHFatPsrHUT5DfyXBdshdFG937qkEXbVVWtX3hRZaLuEVA
	gqrpOhwZEwXYXi3eD88hV9Wix2Y47B2/CCgMhZwTTdM2XIO3PZO+p
X-Received: by 2002:a05:620a:2846:b0:8ca:3175:cc9f with SMTP id af79cd13be357-8cbc8d836f0mr1605848285a.7.1772467059432;
        Mon, 02 Mar 2026 07:57:39 -0800 (PST)
X-Received: by 2002:a05:620a:2846:b0:8ca:3175:cc9f with SMTP id af79cd13be357-8cbc8d836f0mr1605843285a.7.1772467058928;
        Mon, 02 Mar 2026 07:57:38 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:87af:7e67:1864:389d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439b41831easm11282438f8f.12.2026.03.02.07.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 07:57:38 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 02 Mar 2026 16:57:14 +0100
Subject: [PATCH RFC v11 01/12] crypto: qce - Include algapi.h in the core.h
 header
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260302-qcom-qce-cmd-descr-v11-1-4bf1f5db4802@oss.qualcomm.com>
References: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
In-Reply-To: <20260302-qcom-qce-cmd-descr-v11-0-4bf1f5db4802@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Udit Tiwari <quic_utiwari@quicinc.com>,
        Daniel Perez-Zoghbi <dperezzo@quicinc.com>,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
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
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBppbNjIaYMypGt8AbHNF5MYs8KdA7K86/B7cDgS
 54sf6/cmuqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaaWzYwAKCRAFnS7L/zaE
 w0cOD/94s/2bVOYiPJCqENniMi93N9mRVCLsomcrtCgqWQvkUCVNkga72G4hnTw/2yRADy6XCw5
 AaBdMHMZAhqkwyDDEMKOY5lurPDLsKWEGa84cNzNu42n6FPk8fn6zQkRtK24uloTiYe7nh+cB6A
 Vb3IJrFrUxsFV7PulNIIYL1fFbLG97Ih7FGicxvVJH2NoA2Cbsz3UeJ8thK5XKlxbOz6GPqH+AX
 F+idKBhFVulPgzv7whqCc6Y012RFhROz68EM4/haYyBx0faNOkok+XPFGCo6nPOw164Eu2JKjC3
 IX+SAfJXSoxiwSv4jFzy5MMkm1DALxwNW9jO8v0kvS+BR0d8Op8UPp5DuNy2dgHm8pn5CBcHumq
 1ETgZZYJVZmQgQf4q8+eR9OfgmOhOZjZFubdu4f+fo+yeH8XBb1jx84zR6xjG9TGHJwa2O5TiwQ
 4/9SD0YOPRMu7fXfpOn8RPNOrtCyc2tc009e0h94GKnlEgrgjDpieFzn5AQ1Z7UFj0nRk5B57+8
 hS6c9rykHJnGLOR7oOIX4nb6/cuG/kouDAUF+TPDwVWYEd4Hg8FCfk4ESBu+/WdxskI55J9RDcT
 TpM4UmipiuyNO8k/P8QAjdaRMQdaVGP82uw2gPD9qg+NBgF6MGKVSBYKoPX/s+IcmRdIo8MbsVY
 AK3NULbojNbu+qw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: Ejh-2Rs1pEUTs6kGnUXC6MQePGdMuvWi
X-Proofpoint-GUID: Ejh-2Rs1pEUTs6kGnUXC6MQePGdMuvWi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEzMyBTYWx0ZWRfX2lezYv6igKb9
 JGKZvJWHWBE+KAmS0U+Pu5ly2r1aq5BfiU7ATOLk2Y2hLnhl+v2DDAghIlTnvGphxICCPow9ww0
 YHn9uDg2BDi8xpnI8hvtLzi9BQcfikko3me6f/E6n4jk8t4NRo1FAjp0SjKv8RedMmaorBUYd+F
 ddofu3qQgSoAtgMqQ1f0QSs8r0FchqjtcUJmseYq6AzvHZFRoXpilKDMBEr8jy0ko7imJ8qsQwT
 9yOJAwbdsM7NxBRQltpoeQgkL9qFDEuqNeHowRWGp8ql5vkQKpKhonNy0GdKYXtr4e0iPv+//uX
 nYeTDXmrRbaDjM1itVwNowVvtdFyxULyMlGoolZ21GegSg+T13Gg6777ouQHnDvldr/1LT9zUOb
 aS93t8QoQp8cNL5GeZRFphUrIO50QM0V7IxT0gGXgEuHpVhA4tff1ldVHemT57wjNYeExsgnFaQ
 TL50c1UfpMTwceKihIQ==
X-Authority-Analysis: v=2.4 cv=cLntc1eN c=1 sm=1 tr=0 ts=69a5b374 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=rvG61WhHFVBzVmnuldcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 clxscore=1011 lowpriorityscore=0
 impostorscore=0 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020133
X-Rspamd-Queue-Id: 0679A1DCB65
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9176-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linaro.org:email];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,amd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bartosz.golaszewski@oss.qualcomm.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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


