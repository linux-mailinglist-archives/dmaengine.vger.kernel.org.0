Return-Path: <dmaengine+bounces-11041-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAaWM4dRGmrI2wgAu9opvQ
	(envelope-from <dmaengine+bounces-11041-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 04:55:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7544E60AFF7
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 04:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9C92303B40B
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 02:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84734332ED0;
	Sat, 30 May 2026 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk/hASu6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4737725333F
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 02:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780109701; cv=none; b=ZfUsupFOv9jtqiViC/oEfRiRBc5GhoYNw/7uJMr3sQo+x0omkBS9SPqDzDlaO8YVjJtGh+kK2J36Luj8m7maWJJ1xxJPIwqskKk+RXvW/Zl5JphL1jVaVAnxCbW7Ekxlqjyq/0ls/A/nwnvGskESMgkSK5EiX6K9ONcq2+wLAQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780109701; c=relaxed/simple;
	bh=ANnqrdj8KyfUNmk/0JRlqx6jfz8VGeaznSo7wqngpcs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Eayzae++YEZIYShHo1iN7k9ACHe0MrdDF6VofZKWP+ZpB4SNRDJQkjQKsgsNpQwaIAah19kCje7DDVHpoTMxQXPxec+ndEr1aqE/NMThxwVBZBHq2HgbTjAW6qpg/b6OuUCTaT0wQuRM+aQmt5gSCgd/iv2wf1+kw5lzeN8WaXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk/hASu6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b9b15af73so2144944a91.0
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 19:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780109699; x=1780714499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E7CXfCEIYRdM6U6uM6cH4x4hmATdBRQ5XKyC3LDk+ZY=;
        b=lk/hASu67jtOE0hZmXWEh0g9wlzqo+ylHOWarlsoSmZ6oLC6nUDKw7To+M6melN0s5
         lif7oSovCzyiWDmbzeC0lTPwpnIA5W1aOJKK2dRpifHj/r+zNZoVkSVwWPBeuauUQrzD
         wXgAKfuvvgFlbiaVvBuSupfNrZxQ3zGHRNdRYEfB/Ea+zZPwzAGl6xt15J9dyKVaR9xE
         kCtRWHZIu13Lf6sBPUHi9+fUAEX9RKVokFrZaW4gHe0kd/ivuawsa/Pz29G5zHsw5WGY
         f2g6Y+NitV5y1QLv+YUYFKf8fGa57T/ORYKfqHM236HhAgNAO4f9CJTpc/ckZoMoWduc
         g4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780109699; x=1780714499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7CXfCEIYRdM6U6uM6cH4x4hmATdBRQ5XKyC3LDk+ZY=;
        b=rs/x3uZNcrkA3ygIcj/GoOjvGnac3zasJCZTpYR+Hjmf9s+LM3d8R4Tvvm5Z3IRIIm
         rDLCw9GEwbevZUKR+FLa6thROpKmumruUgti8epaa8Nq56m+qs5GjnRO2grRaTs48vIE
         an4PnDAbADhV0zTvpEbmcrV5Sm4/5EsJWxxRw6f4gcqYfZonK8VWQLsNdUoZAQBL6491
         FYFfOnZSBIn6WrZ6eoSVgWPmBiLwCO2ps31ESY/09HnykR3SuJ7d16qgILk6Dk1WsC/6
         x9Ht3JuZLx3Ddj0GskjNt6ZJYae4sf9RukIDrYIaeuq/bXviapqobmcNTfX+89MT+aM8
         XcXQ==
X-Gm-Message-State: AOJu0YwE80wyItSQrG034bIwmtlOUL4HgojjFwMNHfB6XK8LhmmlXX//
	t9WvOq6TDxjZzvYmrVgp9cBOH5VVUSrqfg1AWuY4OWbi2XwtGOeJVN8xglnFUNVA
X-Gm-Gg: Acq92OGbaZYmpnC52oNKfqGpdcGKPewQsIVASXUE6CLA1kKLifIKBg05OJ7fcyDkC73
	roa+GReMOYeCk17QS0//IgwCC186ulBktSPYdqfyVP3zsg+Y552ciOng+XGzR+VNjaH8Ceu2Vo7
	r730Q+O9Ph/fEGGImxboPUHF5ygDAhfwB73HMWWGpB3yvt7ZMIsH5u1xrOIIm+dYjUMw33jcQ6p
	0KQL3Xn/cScdmbXfekgqYEbyixhW4LC5qM8/QzCPlzkLrpTEmlyv50/8Gjvco+TIr72SMPKpKi9
	O5bSd18AKGdrO1iegfjk9fzpCNotQzgcXgemlmRTedE8MCbWZW9RGuJFlyUUbl64yMwR2ltVrkZ
	EI1Q1TCM8Dbm0GvC6pfJfsZH7rL18atz6JEk57eyPk9VEfGwU1c047DSZ8Kib9Q5DisBYauBv3w
	1kn1A9USK7Dt7+KU75peJW+7CfOW17aIbU/z87oVlJ+RTOKMu/oXWCe7C8jvpkWDJiu1LzMVcCM
	/6uZDK8s700oap2bcLDta0Yk9DjZh4p489tmftLOBqKCA==
X-Received: by 2002:a17:902:f60d:b0:2bf:1fbd:b946 with SMTP id d9443c01a7336-2bf3637fff3mr26572625ad.0.1780109699505;
        Fri, 29 May 2026 19:54:59 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23c3a8afsm48165665ad.73.2026.05.29.19.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 19:54:58 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: dmaengine@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2] dma: bestcomm: gen_bd: split struct bcom_psc_params from array definition
Date: Fri, 29 May 2026 19:54:42 -0700
Message-ID: <20260530025442.48710-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11041-lists,dmaengine=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 7544E60AFF7
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


