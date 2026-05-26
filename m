Return-Path: <dmaengine+bounces-10953-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKpgKY2fFWr9WgcAu9opvQ
	(envelope-from <dmaengine+bounces-10953-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:26:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6905C5D66EE
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 15:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE68F3198B71
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2026 13:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D053F9F56;
	Tue, 26 May 2026 13:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LVQAAu3r";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Lyc50zf5"
X-Original-To: dmaengine@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4273F9F2D
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801111; cv=none; b=YyM3W7C9c95lmMg24Y8PAEJubKHW45npa4YxKAdoFtrXpCj1bNo2bV+0i3SpCtUD19a1Lgc7bvGJryZ0fA0U5gBItD4D6zBuU7feez1taFoy21H58u9L5STgEwWcXrfOFiH91xActaP2vg/O9C3SUwkKVlLdAyHQp1fOiuMh/dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801111; c=relaxed/simple;
	bh=wYb8hULMzww90PvO6ikCdSc5niQ+bjPp5Yt9PZ3KUhY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qhEI1b8NTucbH+ON8gdMYyvOHM76yChmi77S0kym+WVzYUSVAkBGEs8EWQJcBulUV01JjO+SRaL6FRYjdeQaqYEZX2vBVytBK9xaj3/peE3/60FsmdPQBsvBRxbgrBk5XggV0klA0xj5c16/NJy1gz2G/wOFR763mXeCzt7TQK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LVQAAu3r; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Lyc50zf5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64QCsUbx2385433
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	heR+Rq57taQJntO27O6cewlt6NKto0RiHGK1KQcUICw=; b=LVQAAu3r4aDq6EIQ
	7bR/wma6Rra4RG5Yhk+pjblvuattCKxBpprJ/R9sku3jK0CMH5qP8Y2j+YlnWWmp
	E5WWGqXyM/G0tbrYFxQWkDrLMwOTACv0NCFDA6xEARmf0ba/Px6nSY+BjU5jZ73o
	h3FRnAnBsaMxpiFaXcywmGtnXDymY6wayor66LjQhEFZxTofhZrII04G7spZfvfH
	Wl14zwh8c3fISM21okivh5RHUzZOeH3ADHS08Tg6729xt9w7ipgWoMaqckON7+/L
	YDwQnnDvwSKhwNmhkg0sflb3sSpSbQvDYYdNQ3mZ9CaP772w+OVPCoM6EbTPbP88
	WLu2dA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs4t80-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 13:11:48 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95fb57bbbcbso3354672241.0
        for <dmaengine@vger.kernel.org>; Tue, 26 May 2026 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779801108; x=1780405908; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=heR+Rq57taQJntO27O6cewlt6NKto0RiHGK1KQcUICw=;
        b=Lyc50zf525fKOHXJkQOLo0KCi6NqzA/dJx99v+ctnekpT8vaW5SAn/g4bpqbNmR9tz
         4Y+yuwPT7uof9R3XIqaCCgXBw/mU28UAinqzv2OCOUCnLYeVrKFRBMXnPjCj97JCJ6He
         0bFXGDe04uzP+egyq61cc9ymtrfEaa/HmZmr9hxfOhQBnafeB1mZHKZaoo0gWCUxCOH0
         rwbB+Om+PGBi66cibximFFtvzKA2UL7iiEU/83zeDghP74LHHi3mdpC98en09J5LUieA
         GduZexhkjQwLdMKC0/Djx9wQiJ480uPrtFipF+GM8QJ22lSx/W+JBk4W0H2aw9RuPueI
         c6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779801108; x=1780405908;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=heR+Rq57taQJntO27O6cewlt6NKto0RiHGK1KQcUICw=;
        b=fFZtV1c5QQ60QjnXmStD4Evriv1lv/UDZ1deCk34oHGX+B8U6UFrV+asgQLoXriKUk
         bqpb98GipBszm/f4uJCGdzx5nwXkKMnOp6PWrMIE+6rfvYC6SfYh3HG1IQCWwruWHGOA
         v3eA+qLnPyHenMK5FHQQmEKUy6srPhr63onYQiL+6VGGNoROBVg+gIFvBbrkzLMRMh2t
         Tizuq5RqysfNlNCHt5WEkpT5KXMQOxYr/jWgplFmNOYA63lDsh74mE7hOuo5Vn+bA8Ue
         bSaS4BFRCBURMyq0b4buYPi9vD83mKlM3olu3/G7ZIHLEctO3YNQIDRaYzrjP1s3zyAR
         CVOA==
X-Gm-Message-State: AOJu0YwUEPD7KNmQpAkMrC/hkFHeSxrYSplCGRleBBkKglSrOnCSjK4L
	zcFWwGa6rWJKw0m5dafZBnXhll4daH75l/Ga8gynT6Q/BPnVtaUtVRLBgMUBBCVGxKC9v1bFaVx
	3ZpqdfdYQNg9RRFmeiID6HUfScH/p2LY7acF59hp23+5HucnU3eXlj2tyvKRsFMc=
X-Gm-Gg: Acq92OH5YukGd1nXUle+lglJFHTKB+VK0QK0R+chUyognuskm+7aCzTyECblTeP4A2u
	R4DPLE8f99ppRsWj0+rhmXdjaiAxMY+6uGgA1og6oxx7zE6dZKtbkTdGKToCHZ03bG3AuxdzFXX
	XuNOf6i0qcRkHlNAQVtx7Zl+L55pEWXsb7PyunGYPCBOkHb+KjfzRTLLRfO72UTCelN5Id4KvCd
	vJ8R3rRNVT4K1vQx7YOfX42CDFm8TK1c7D4ohm7NKe3VP1RZwlzEfy+KN6tv6moQZoneMtasm0t
	VZfD2GFbrd52WmZyyl5E0ZVkCvO4TimaHyXHBjkdYVcq30xP30fXna2zGq+x9FvZHr2vuY1ixQt
	TwlffcioLg3B20CTCW/5eQJoKcbk82qrGPccv4BEZVRYPb+jDfN4=
X-Received: by 2002:a67:e7c9:0:b0:631:2dc6:2f5c with SMTP id ada2fe7eead31-67c646469c3mr7519344137.0.1779801107503;
        Tue, 26 May 2026 06:11:47 -0700 (PDT)
X-Received: by 2002:a67:e7c9:0:b0:631:2dc6:2f5c with SMTP id ada2fe7eead31-67c646469c3mr7519273137.0.1779801106934;
        Tue, 26 May 2026 06:11:46 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:15ba:1d70:65ea:9578])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d5e484sm34259426f8f.30.2026.05.26.06.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 06:11:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 26 May 2026 15:11:02 +0200
Subject: [PATCH v19 14/14] crypto: qce - Communicate the base physical
 address to the dmaengine
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-qcom-qce-cmd-descr-v19-14-08472fdcbf4a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=wYb8hULMzww90PvO6ikCdSc5niQ+bjPp5Yt9PZ3KUhY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqFZvzxsEoOkXKERoBmJ+YvCvy9mO2/ZVwzzxGW
 SkD5+eOhNGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCahWb8wAKCRAFnS7L/zaE
 w01UD/9Qd52H3q5VW0VL6E7KzqRa+d8K+Y+jYtcVKzVY5jLZ4SyZVi3tVBOS1l4w573XttjwpQ9
 bLmG5wgI9YwBOYEKor4l2B4NV5r1RTzWWYY8kkHZbY2pR5ot3GRBk41IHrFkKqJtLCUihkZyTM7
 BRvxv0cDH07RHmyCDeInlnwULWxqvKJtnval/yE78/Rv4z7XOflmK5RLA/3E8agAXFd2qK+EBSI
 HCHt+oBWXtmabclRSm1us0rmipHIsMJu/GXiKVd+Pwl/WF5N/cfq3SxN38ttYfXKzBv3RfSMB/v
 OTK+WGPkOU5rs3mWfHtvQfbArbPnV786v5NWONXLKaohikx5KNatccGpQ5aeQ/WuaNLreW5d0CX
 d+sKayWGvRazJP5WhH7iaw2NE3Ik5X3/AbDFd019x5fs8E0IeQX8CqZvFFQgx9GwYVKh7m8++xj
 eCxrHcDnnjwKXMqmRLUqLEDmxt96FpTmSrvubr3rO8WmtR2K1Rr0+il194IajYmFaXto42h10+P
 J99xrA80QX3GCp6IAOIQa528bkuLn//rMcbinl9x/FWfJN8PNWeyJLTgC+FViy52icXv9KcIaIR
 739qnqXKU4sjQtDrC9EjPhGwzEJJIkxAReeSaJ/bI50Kiy9PgYV3iUz+9wgtb1/+x6A5iHcgS97
 3TG2vGnfRcU3DHg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a159c14 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=TFgmKHP77OfOvYwKDSoA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-GUID: 83OwTB7eO1cK56iQJPujvwhVwfFcFj-7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDExNCBTYWx0ZWRfX2N9rhBuxbFVb
 FX1Jw1JYF5UZx7+HryjpfcmI3xx0OLb1R79by/iKDrzEJNLAgZtYhFm/9icKOSmnLC0q1WLwjxI
 z/FEODe3C0dxuSzWElZUKuIOtoDZH7k6UCp3X5/UchRNnK5T9NqM4sAitQYEhPHjr5fBxJx0hO6
 kZ6gWRh1l8FONAJllDJylOh8zTVjW+mrEgLckKCmYwB5XutJuVSYZUK3keEKkzAfnHxYha7Gt5j
 VH0PVdYOA5bbXQlB0DenKg2y3rpMKHa0sU4RehhtO5AR1OFi4rSL7AkWKaLvHfNWH7Nj5h8SIXW
 h08sf8drpA39T4FH+aMfJALivlla7R5NYMFSLdbJHMaRby84xa5L4fkjQSi6/iniJjFkq/iJ5yW
 erghUIfiHB5AF0cRKNXKAGt5Lrsnadj3hiFuXRlJlAMwm84H2f+lnLHlfuykrjmM6MWcFwLqhgi
 hjITwLfPhqrjVvqPOKw==
X-Proofpoint-ORIG-GUID: 83OwTB7eO1cK56iQJPujvwhVwfFcFj-7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260114
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10953-lists,dmaengine=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FREEMAIL_TO(0.00)[kernel.org,lwn.net,gmail.com,gondor.apana.org.au,davemloft.net,quicinc.com,qti.qualcomm.com,linaro.org,amd.com,codeaurora.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
X-Rspamd-Queue-Id: 6905C5D66EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In order to communicate to the BAM DMA engine which address should be
used as a scratchpad for dummy writes related to BAM pipe locking,
fill out and attach the provided metadata struct to the descriptor.

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/dma.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/crypto/qce/dma.c b/drivers/crypto/qce/dma.c
index 769cc71da90076be446cbdf7ec7db27f628fa2ac..349c1d9ce9a2f4628087aa4ed5f8dda2bd9eaedb 100644
--- a/drivers/crypto/qce/dma.c
+++ b/drivers/crypto/qce/dma.c
@@ -11,6 +11,7 @@
 
 #include "core.h"
 #include "dma.h"
+#include "regs-v5.h"
 
 #define QCE_IGNORE_BUF_SZ		(2 * QCE_BAM_BURST_SIZE)
 #define QCE_BAM_CMD_SGL_SIZE		128
@@ -41,6 +42,10 @@ void qce_clear_bam_transaction(struct qce_device *qce)
 
 int qce_submit_cmd_desc(struct qce_device *qce)
 {
+	struct bam_desc_metadata meta = {
+		.scratchpad_addr = qce->base_phys + REG_VERSION,
+		.direction = DMA_MEM_TO_DEV,
+	};
 	struct qce_desc_info *qce_desc = qce->dma.bam_txn->desc;
 	struct qce_bam_transaction *bam_txn = qce->dma.bam_txn;
 	struct dma_async_tx_descriptor *dma_desc;
@@ -60,6 +65,10 @@ int qce_submit_cmd_desc(struct qce_device *qce)
 		goto err_unmap_sg;
 	}
 
+	ret = dmaengine_desc_attach_metadata(dma_desc, &meta, sizeof(meta));
+	if (ret)
+		goto err_unmap_sg;
+
 	qce_desc->dma_desc = dma_desc;
 	cookie = dmaengine_submit(qce_desc->dma_desc);
 

-- 
2.47.3


