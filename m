Return-Path: <dmaengine+bounces-11039-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFMJMkg9Gmq02QgAu9opvQ
	(envelope-from <dmaengine+bounces-11039-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 03:28:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F5B60AC44
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 03:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9476B30146A2
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 01:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0D247DE1;
	Sat, 30 May 2026 01:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZjOfYBS"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B453241686
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 01:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780104375; cv=none; b=VgDtuuEw26k+yiZmqfUeYM6hKmb/zLNtwskOxaVoiSolJwUSplj52pnn29s6L1R+IOrjWlbnLZk0+Er1PgJdYAtbi2ea0T5KO31DsirUxJ6E9Zn9t2r3YI+1+H11047T8sbjNG8VW7TNmAVwnxvNtMYMBxoxXrCS+DFWTMJwPH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780104375; c=relaxed/simple;
	bh=ANnqrdj8KyfUNmk/0JRlqx6jfz8VGeaznSo7wqngpcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQtwo1+tXfSQhP+ouekii893SsJ+FvHSqXXPwUPmCf3oDgtAkvp0ND4Ah/vSSG6T/iOPLSM5RS6SScIjIuIEMAgzKLBDhsGJs+ALqS+XMIWdOBK8URBH3nR3oI4ETwwE4Fdc88ezsVPP44P/VAF0oh18AzWF33TycF1c3DWSJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZjOfYBS; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8cccdf044e7so26978946d6.2
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 18:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780104373; x=1780709173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E7CXfCEIYRdM6U6uM6cH4x4hmATdBRQ5XKyC3LDk+ZY=;
        b=eZjOfYBSp970eLc50xhuOfJUwXpUgxZM71z0s09QMBPFyIwg3LaL5jR+vFdC/XBi9k
         JHIzYljjLWXZRDXCZS18WTN0cnLy90iGkCPozRQXPkrBNy2gLtqDLERdVEs0JICTHTEP
         lLAteDDMPof5Lu99E0JX2sNDEzkAwAJnFcm6e3pp4sC+N8G6hX4l9OLVbi8c7bwwS9fv
         gf6C/XZX+IUQhXjjzXVeTfTT+YbktWZ4r9fqAhBZp7vfy9I5aiwlpbNwUQ4j7AKwAjqo
         TU25TK9U6IKY+YRhhqWv+zabFYDnWQc8rlPEyW/967iLkdMuFVsL3r9gU6eYj+gKHykV
         Ao2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780104373; x=1780709173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7CXfCEIYRdM6U6uM6cH4x4hmATdBRQ5XKyC3LDk+ZY=;
        b=kRmQvd551UzewG7SvgcNGXpl1Jov+U3PRVLJkmQeWOBgKRK9NQi/FgSV4Gk93x878+
         QTQTZYRVmzPXALUZJ1SHXGe3iinZGPj0HthAFtX7I8f6ov5QGRitc5BC1kaAGeXPhVsJ
         wxxK3gKy5dq5zY1gJxeSrOx2CQzoZshU5eR3dA1FCZ/9Ezt1JCC6wr4XMothKEMTG6bx
         /NEnQuVDaZpbynyGyvE9x8J8f4b/DC+QS9Xy9r2qEg6+PkJFH7NF5rVz3i64+9FQMPos
         hlN9reoqQEY1i4bm8RFNGgf7Oke1pft+gDlh8Hg3oFILJi8914YDjk7rACOUF1Bbr4De
         tZEw==
X-Gm-Message-State: AOJu0YwCos+HOXgkBBK2N653ud8we6GmFZgcsqwHLHiAmah5yvRe4dbQ
	5POFRx0GzIBJ2+9EubgJ7aF3jihXOOYVTqqa4ZbPQZpYMXSfkfNP5B2G8WZaCaUE
X-Gm-Gg: Acq92OES5Rcw4wOELt743nk1Am3s7OarByawyRpuTYfSep6WR6kBP2QXuvQSGdxCrxC
	9wzLR36OKxQ6Gi/X8PsL2bIwRIlkh5dXvLcokBrsCHmgAS20ucwIUzBLKS2qq2ZOew+huJpZDOq
	AmONkUPiMtTbGLqbTbvNmDotBvlPY8Osw8pBhEf7M8TP9V8iGTEXs2Dc3drgEp6eKuCzrwKgh26
	AHLejc6FCFDVpW4DMgJgCnO0omY8J4uWPSWvr4zHZSLKG8j4wnDL3umdrvGSjSqTNABwVDxmb+7
	yHryjev6hr7sGBXqs/v5uucvgsPm1yVSJ3cCjlWZPN8AEWvFHRUyM9vjTWHjoi0DTm8ctiz2Yef
	Fy55zrFeiLuzSfjeVc5uQoD+i09XaW4JriMpxbon5x+9i9iRHJy28tD+3lDlNp/V/fqPqxKpw7f
	tinVWAjhm3LIG9fLv/2GbCGTDDokzarPexyFHVVPlAw9u7VjTrYihOhViPsncunZi/kf/SSOpju
	TSSadAE4N6g15G3D2JhxbOx1wppJSghLJabYCRA4oo9kg==
X-Received: by 2002:a05:6214:2c0a:b0:8ac:b471:efbb with SMTP id 6a1803df08f44-8ccefdbd94dmr38864786d6.24.1780104373151;
        Fri, 29 May 2026 18:26:13 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ccea2163b0sm33572586d6.38.2026.05.29.18.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 18:26:12 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] dma: bestcomm: gen_bd: split struct bcom_psc_params from array definition
Date: Fri, 29 May 2026 18:25:54 -0700
Message-ID: <20260530012554.68605-1-rosenp@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11039-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 44F5B60AC44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The combined struct-definition-with-initializer pattern confuses the
kernel-doc parser. Split into separate struct definition and array
declaration.

Also now that it's fixed, it warns on missing members. Add those as
well.

Since this is just a lookup table and not modified, make it const so
that it can be moved to read only memory.

Assisted-by: Opencode:Big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: add const and add variable descriptions
 drivers/dma/bestcomm/gen_bd.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_bd.c
index 8a24a5cbc263..61b5746e1a97 100644
--- a/drivers/dma/bestcomm/gen_bd.c
+++ b/drivers/dma/bestcomm/gen_bd.c
@@ -254,17 +254,23 @@ EXPORT_SYMBOL_GPL(bcom_gen_bd_tx_release);
  */
 
 /**
- * bcom_psc_parameters - Bestcomm initialization value table for PSC devices
+ * struct bcom_psc_params - Bestcomm initialization value table for PSC devices
+ * @rx_initiator: RX initiator ID
+ * @rx_ipr: RX interrupt priority register value
+ * @tx_initiator: TX initiator ID
+ * @tx_ipr: TX interrupt priority register value
  *
  * This structure is only used internally.  It is a lookup table for PSC
  * specific parameters to bestcomm tasks.
  */
-static struct bcom_psc_params {
+struct bcom_psc_params {
 	int rx_initiator;
 	int rx_ipr;
 	int tx_initiator;
 	int tx_ipr;
-} bcom_psc_params[] = {
+};
+
+static const struct bcom_psc_params bcom_psc_params[] = {
 	[0] = {
 		.rx_initiator = BCOM_INITIATOR_PSC1_RX,
 		.rx_ipr = BCOM_IPR_PSC1_RX,
-- 
2.54.0


