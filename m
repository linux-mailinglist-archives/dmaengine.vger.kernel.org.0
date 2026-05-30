Return-Path: <dmaengine+bounces-11062-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FcPELBCG2o4AgkAu9opvQ
	(envelope-from <dmaengine+bounces-11062-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 22:04:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9E161329F
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 22:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A41BB3042268
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 20:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4C230FF08;
	Sat, 30 May 2026 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s1UkTb8M"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A71C5F11
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 20:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780171423; cv=none; b=LfdYaIxNCFkaypIhB8eSlVKAvra58ADpfTN720XEWfv9A1v3QYkAbmt4jT4CdqOu80cOg7uRLVR9U+F9Hky1M/YVM+lJ50I82mkyvDS4Qn6lkdbODQqtjKX9h0keeSQkESQYJ4A3oqahn72IzZoYfh00nbhwHEO9Pm114tG7thU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780171423; c=relaxed/simple;
	bh=qGuU0FY9EC3BydvpG6U9zrZROk7ctjkey22x/b+9NSg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X6CXzrFX5YeTC5Ec7v+WQJ7EcYfpEI5ZdzUea0LNpSdFG3HJ5T7WE7cD7giEZTyFQhPDtZjPVuiIQI94HVjVt3DgsAlGQQtO1FxJPZsoLR30M7bcIRmfAbVTgqbb0QmSkxMtw9mo+drkIOotT5gnQMUC/Arc9LsSL3Y6xqnO0cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s1UkTb8M; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2bf02708e8fso21244305ad.2
        for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 13:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780171421; x=1780776221; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UrvUN2RvVIlyZJtVPu/MDGWt5JkIRgb0YfzdTTO4z4k=;
        b=s1UkTb8MCU83hgIIupLB+lDKyr6dBnjA+Swgze0d2iGPhoYdsSgOrjFXJ5yNJWioG2
         igkrXCPkFqD/aq3k4IFYYc0g3T56/ETOkpN2l7SjEF24Z3k73c3KcGRussPnCS3HVoyQ
         MLCdVhuHNTHdAiTzYltXdUfvfhpuYyfZTU57B5LeIj9/MCUprEPKDrqLVdiIS+p5tc35
         YKKwpLZJ+w2aaeqLRVKHJ9gsm8ck+3CtoZCdMUBVdHNZ3X/XtvYgz/fNWyUROofRTPb/
         1VTvwh1gTiaMRQ+9ftB0DuGRluOeX7xGU0cwOB9GK4C2J/ATZ7gOJXmtFJukmZZdrqxp
         r/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780171421; x=1780776221;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrvUN2RvVIlyZJtVPu/MDGWt5JkIRgb0YfzdTTO4z4k=;
        b=NFl1J56Ky3uHJRaMb1TzEBDOSl6RxJIKTkVR9rHPVGy8VQ1T4i53FyAfpGY4JumLAa
         xzMpoSVwlxYILtxJ2MSXXrslf+9p3A2mJ9r1CasirZV67gV09qAXQ2L/tqsTVAq35Te4
         6Ul+TpOUj6QRMIUy2IFmfporj3Sg3p3chSXA/46OUPpCBZZoSLJl7TPObHCX7DWukeAZ
         NTSFLhWoDWahBBL/If9xgCU/TH/alMH61h4+isqRIrqr7vJDRO6pzCVgbHWY8k7xWNfe
         y6QACF1rrv0NOlGAJoibfQSxiz1cULcTD57FkMkSPOEzvHaEkxC/YmcGWKcygMLAWQap
         InwQ==
X-Gm-Message-State: AOJu0YxliHZt0oiuEWIsG3Is/Rzupa+KKLDzEJjBSNgO8bmJB0JtQecB
	iQPpAGf3Ubg4zL5g6/r8Bsh2HYyQNWEsTgfhvshJLSdfwv+9NqC/t7QYakq3xhQr
X-Gm-Gg: Acq92OGvXNHFlqsWDDBF8VWGagu8hRZTmlLegRCLjXB9N8Nb7els8PVBQxyFp0epIgf
	G8audS29CWXHndXysFmk67J1Bvj5vPVgLyinHirHf24XdiONiWlg+gFB+exMkiDTOWq5QGRJrTg
	wF5o8uWlaPLB+Xfy1BOybdHulG09ekGZTx1jryza6wzrsmq7DY7V7LD+swisbSmgtlhop0pOdeb
	nvGrr9NaK4DamOlPrVODD+aB9knMVMw2aBZzcOaR3Togd4JUAAPTEhxROCVmAMbB6oLZKsMdPth
	ppBgWg9ozP7T2jVxidSU0+gLZxl2g7ofM5nL9BJ+J5RtyrsEw3YQEF/Ai9IwSuiWqM+22dhQHLO
	RKbvtqTrTZ9yofMOUkVEF/wF7+ZQWfVNUWdzjCx6b3ycqsOugh9HBjMH1FFLmmCshMMfQgzZ4z9
	Y0BlPDJ5EH92GHnP70muzvomr4toqHZymXS5kaJmxK+hJjfKarEjt69ae4f99cfXYZnzoS76ySH
	/vYNS+7uSYxfVkUMTLiV4f01eFX+swkQBFcDjrUWHfPeQ==
X-Received: by 2002:a17:902:e742:b0:2c0:bf68:b1e9 with SMTP id d9443c01a7336-2c0bf690765mr8383945ad.20.1780171420798;
        Sat, 30 May 2026 13:03:40 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23a22ae0sm52793985ad.35.2026.05.30.13.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:03:40 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] dmaengine: dmatest: split struct dmatest_info from variable declaration
Date: Sat, 30 May 2026 13:03:22 -0700
Message-ID: <20260530200322.7584-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11062-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AE9E161329F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Combining the struct definition with its variable initializer confuses the
kernel-doc parser because __MUTEX_INITIALIZER() expands to contain braces,
breaking brace counting and causing:

  Warning: drivers/dma/dmatest.c:152 struct member '' not described in 'dmatest_info'

Split into separate struct definition and variable declaration, which is
the standard kernel pattern.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/dma/dmatest.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index df38681a1ff4..2ae3469397f3 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -137,7 +137,7 @@ struct dmatest_params {
  * @did_init:		module has been initialized completely
  * @last_error:		test has faced configuration issues
  */
-static struct dmatest_info {
+struct dmatest_info {
 	/* Test parameters */
 	struct dmatest_params	params;

@@ -147,7 +147,9 @@ static struct dmatest_info {
 	int			last_error;
 	struct mutex		lock;
 	bool			did_init;
-} test_info = {
+};
+
+static struct dmatest_info test_info = {
 	.channels = LIST_HEAD_INIT(test_info.channels),
 	.lock = __MUTEX_INITIALIZER(test_info.lock),
 };
--
2.54.0


