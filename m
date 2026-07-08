Return-Path: <dmaengine+bounces-12151-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X+n6Dj3WTmqPVAIAu9opvQ
	(envelope-from <dmaengine+bounces-12151-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 00:59:09 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A0472B033
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 00:59:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=A3rCNkaW;
	dkim=pass header.d=redhat.com header.s=google header.b=nHGV38MK;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12151-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12151-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 900FC301FF80
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jul 2026 22:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02511385D86;
	Wed,  8 Jul 2026 22:57:39 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B253859E3
	for <dmaengine@vger.kernel.org>; Wed,  8 Jul 2026 22:57:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551458; cv=none; b=UhIh6w/DreAMEJFMU7/uSKkm99u4+djRMD5qeu1+oU5Sg8rtf2pmclxxSvVQvXHdUDekqeUeiTMM6IaKYitlSwXiRNfjdK4hVM+uG8TLB52eMxDRkIsfRG4ELJmn8C3EHSN7OBRstujSwK0lpYnwTjCqUnKYcySSpbKEVtfKOGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551458; c=relaxed/simple;
	bh=Z50bzthJNfs+JWY+/lA/BczsECHOt62WBTecp9PvTB0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EHBR4LzUXC9HTF1Cy7GSDM57KdL16zht/0nDxVLsbQAntKKgxQdr4jSCWJ1jAHqWWEiN0rciTh5GOgt+oSITFp3DQ21qqhWXVRGUG1ew1MC9ug8HoE0RMA6cPiMunDL31OnyD+XSx2TTVSvZTn+LW+Vu1kmEJb65nGjElc8s2WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A3rCNkaW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nHGV38MK; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783551456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fnfpnijAPGtHEmnLcDzWqhyrVqBME7LROfq58vNnkOM=;
	b=A3rCNkaWqi5egaRC1BLnBBj4/klfQJ85/ADp1e+DMkg0AbLVKSdLM29XQXCOPAloQJxxqi
	Vi5zEfmaTqWGAaAq4gmlZ3Hcu1Ye3opGuYeRtdi2VYs7Qm6MHv+1OycLCgFgeh8ngTOiqH
	cDgmQLJYzVt+81MLhNegp3qsx6xNqAE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-rzlQ4uYBM0y-G-x0rw_z6w-1; Wed, 08 Jul 2026 18:57:35 -0400
X-MC-Unique: rzlQ4uYBM0y-G-x0rw_z6w-1
X-Mimecast-MFC-AGG-ID: rzlQ4uYBM0y-G-x0rw_z6w_1783551455
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-517e054fe07so25460061cf.1
        for <dmaengine@vger.kernel.org>; Wed, 08 Jul 2026 15:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783551455; x=1784156255; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fnfpnijAPGtHEmnLcDzWqhyrVqBME7LROfq58vNnkOM=;
        b=nHGV38MKBh4JeA+mTUUWmduke6mKO9/iaOFbAcWvlQp6yzE19tf6f+ulw6/gjxMjYp
         pTLVeOqasySj5ICsDrkA0gsiF21ybd5aVO4HqTuYvD9WGsLRVlUIoZh0dmR9+SD+CGCl
         HIOqMTk3Tp0DJyPllXikFNSQlnRrHu/sc9P/C1nxbstD7YLDdj3VrKHgEMQNlAEyXfQ3
         3RTPMdXiRbd1j7wKfrIwoC5e9NKkBatHEiE5mXJmw0v0l0B+2Nhym2rbD4F8BJ7PFWh1
         SmBot/8YCRAHid0l6somPGHo5YmJf5+O8uV8ppUrMGATizmA+bdbYwxa4BTuUa5DSCnB
         F+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783551455; x=1784156255;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=fnfpnijAPGtHEmnLcDzWqhyrVqBME7LROfq58vNnkOM=;
        b=Wc0yOzjV6KwBQYhc7CqIHgXINq0sLmAe0qE38Uy1tKp5mf8ums1uYyZ8cKpK03K45h
         GLzZ0m+h7A+shp3kATG+V2Qx6+gjHbene00MPd3/1OyH/uaZ4Ap8xxHwgfdOSnpLX5dL
         ZyJmYFVDv/p7JTPBTslcUY0PUPu0l5imlYYqbDBNXRAP+iX9oes1UnZGiHSBhfY071Sf
         oGln3ylVdvncN1GqF5yW7nkPhJ02q6UjUljM0AXTk0jAPgCizCktWh2uyMQd5lD8V56B
         FTo04nyYyKzs0nb30HauqP1dPtNc3JpBuQ6KbZbrxUbFzv3qQTiGBnWAxwLZtnHs78Cj
         ke6A==
X-Forwarded-Encrypted: i=1; AHgh+RqjVqUAfVi9yrjIO9DVA3+dRzYkWZtGO0OOq0Ss8/1JJhFxQW8L4nqjgrJ1MMy7Vuo269gP0ZkETXA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJtIpXx2iOJKTqOS+P5RX0QbYdIDtDP7SAHtrajFiSMk2bcp7V
	y4ShyMlFuwMXsgVBV95WIzr01h2XvfDKD0PjWlWaQwZ23Kw46zaiKWHOrHLBTsl+/+WysOBeDDP
	mzC9jcC3cJH8LmfeUal/wpSJAImnSApO94JMfZ8NmyUdecZ1c+4WCBT0gxEILb+aDdNZ1QA==
X-Gm-Gg: AfdE7cml2aTxF1fr+V9se/xJl7Bvxs0w2hnHUKwitCbG8u4q1tHGY6yDCSSXanNA3ms
	QOq8mKCivrBsI8roA7j3jRclq8GYG8ESD6DS9+weIJdwazlvWfXNWvIirUgHhWubDuFZlD/iN7G
	gIzS8otbes70bJ9MKWVxiJqnRT8x7R09S4gdBCigE6G2b3BlKgvZeV+1ksvvtu4yuBCZTj8qo1d
	s54n0yE/KccPxNKepyDdyC190Cg+tF0n/f2OOXPUIXJ5jxNbfmqtYQsMT+IvlAaKKjdlOCE4kxx
	uGmXOhVP2aLKcue59C0qzvMkey4HYkUSO1ADFTWQBtqrwtwLDRbzABeoa6/IBji/hFrmg09G1lo
	I5hlWjDsvYZU+
X-Received: by 2002:ac8:5f8d:0:b0:517:6350:ed4f with SMTP id d75a77b69052e-51c8b3e426amr47450421cf.34.1783551454860;
        Wed, 08 Jul 2026 15:57:34 -0700 (PDT)
X-Received: by 2002:ac8:5f8d:0:b0:517:6350:ed4f with SMTP id d75a77b69052e-51c8b3e426amr47450201cf.34.1783551454372;
        Wed, 08 Jul 2026 15:57:34 -0700 (PDT)
Received: from [10.239.101.46] ([69.43.42.202])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c42038c4bsm145173721cf.31.2026.07.08.15.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 15:57:33 -0700 (PDT)
From: Brian Masney <bmasney@redhat.com>
Date: Wed, 08 Jul 2026 18:57:25 -0400
Subject: [PATCH v2] dmaengine: qcom: gpi: correct gchan in error paths
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-qcom-gpi-err-fix-v2-1-49c9be055501@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NTQ6CMBBGr0Jm7ZhpkYa48h6ERQNTOgsBp6TRE
 O5u5QAu38v3s0NiFU5wr3ZQzpJkmQvYSwVD9PPEKGNhsGQdOdvga1ieOK2CrIpB3kiOg2lvTe2
 ohVJblYs+J7u+cJS0Lfo5H7L52T9j2aDBZvB1IApsuX4oj9Fv1xKE/jiOL5TCgguxAAAA
X-Change-ID: 20260625-qcom-gpi-err-fix-06ef18453608
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Brian Masney <bmasney@redhat.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2152; i=bmasney@redhat.com;
 s=20250903; h=from:subject:message-id;
 bh=Z50bzthJNfs+JWY+/lA/BczsECHOt62WBTecp9PvTB0=;
 b=owGbwMvMwCW2/dJd9di6A+2Mp9WSGLL8rt5N6bn7Tj/l3IIND9cxLby0n/WZiPt08+UXPxnf6
 97HJr8go6OUhUGMi0FWTJFlSa5RQUTqKtt7dzRZYOawMoEMYeDiFICJzLdl+Gd08HWX7+wkPs7+
 9PAwcYOPj/nf5RvNMDGutRIUV+RTtmX4yZjf8EGxYsG9uP+lCgWGRcv5xFQnyOXLctYseLY17tM
 8HgA=
X-Developer-Key: i=bmasney@redhat.com; a=openpgp;
 fpr=A46D32705865AA3DDEDC2904B7D2DD275D7EC087
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:konrad.dybcio@oss.qualcomm.com,m:bmasney@redhat.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[bmasney@redhat.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12151-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bmasney@redhat.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 60A0472B033

When attempting to start the Fedora graphical installer from a USB
thumbdrive on the Lenovo Thinkpad x13s laptop, the following errors are
shown in dmesg multiple times:

    kernel: gpi 800000.dma-controller: cmd: CH START completion timeout:0
    kernel: gpi 800000.dma-controller: Error with cmd:CH START ret:-5
    kernel: gpi 800000.dma-controller: Error start chan:-5

Looking through the error path, gpi_send_cmd() sends the wrong gchan to
gpi_send_cmd() in gpi_ch_init()'s error path. Fix this by passing the
correct gchan in gpi_ch_init()'s error path of gpi_send_cmd().

Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Assisted-by: Claude:claude-opus-4-6
---
There's a separate issue with the graphical Fedora installer not
working that I haven't had time to dig into further. I can work
around it by using the text installer.

Changes in v2:
- Commit message cleanup as suggested by Frank
- Commit title cleanup as suggested Konrad
- Add Konrad's Reviewed-by
- Link to v1: https://lore.kernel.org/r/20260625-qcom-gpi-err-fix-v1-1-5ca3f00fe2e3@redhat.com
---
 drivers/dma/qcom/gpi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..3f390b5821ab 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -1965,12 +1965,12 @@ static int gpi_ch_init(struct gchan *gchan)
 error_start_chan:
 	for (i = i - 1; i >= 0; i--) {
 		gpi_stop_chan(&gpii->gchan[i]);
-		gpi_send_cmd(gpii, gchan, GPI_CH_CMD_RESET);
+		gpi_send_cmd(gpii, &gpii->gchan[i], GPI_CH_CMD_RESET);
 	}
 	i = 2;
 error_alloc_chan:
 	for (i = i - 1; i >= 0; i--)
-		gpi_reset_chan(gchan, GPI_CH_CMD_DE_ALLOC);
+		gpi_reset_chan(&gpii->gchan[i], GPI_CH_CMD_DE_ALLOC);
 error_alloc_ev_ring:
 	gpi_disable_interrupts(gpii);
 error_config_int:

---
base-commit: 6c94b38b83a04c43ea49004275f0391404051093
change-id: 20260625-qcom-gpi-err-fix-06ef18453608

Best regards,
-- 
Brian Masney <bmasney@redhat.com>


