Return-Path: <dmaengine+bounces-10118-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wN7DEM+q62nfQAAAu9opvQ
	(envelope-from <dmaengine+bounces-10118-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 19:39:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE5B462099
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 19:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 248DB3007883
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2026 17:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0C23E5EDB;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttA/Mfd7"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13E37268D;
	Fri, 24 Apr 2026 17:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777052364; cv=none; b=eYSKjpL+yKcXExtnjKSOPxi5j6ddiH1Pjloi6/nYfwqY62MPqtC+qAaowmmlmdWB4WUVzGpKMe44D+VIgHanhIGr18G8z/V8tMWNRuTl+Ao428OYJ42/QtaS37sWU9jGUGdWWoYiOeThxQpH2X+n4KUzZJS1qqEcSbekVlpf49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777052364; c=relaxed/simple;
	bh=xZL6Q8zEKVnEPzDpoBXi4fY8xiM5sA7I1SfhLEzZKX0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SDgP6o6FT0o7JrTuezju2+wQCwwnM9Toxkxm92FZzLfQSqkWm5fbBXiaUFJ5RXj7a9AHME5X/jUmYhdv/7tkg1BkjQzXhfaW0b5CE2Da34cmOiGcI1THrhCh087uMTkVb/oe1XUMQkBK7gUWXVEnK5+D0q6vzzPLfCOF7QfKrY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttA/Mfd7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EADA2C19425;
	Fri, 24 Apr 2026 17:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052364;
	bh=xZL6Q8zEKVnEPzDpoBXi4fY8xiM5sA7I1SfhLEzZKX0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=ttA/Mfd7oQITL2fqLEA5YPUwfuq0XVUgTPomecxDpLhvVdQvr9NLrpMtP2ixZX8Tn
	 rDqv8ugnTUdcg7GUCNuG2GOOSPSYPPQSvJtQK4rKR7Vv4NxuqKrJ2LTqNu10RXlhyX
	 PoMNyrDfPFysGTkSad94EtawR9u3JfU+gU5FzOMKRsWzrCpkpLZ876XRzDxJgwUQNP
	 FMrcdHAgVskR8dKHKvxbbPsuH1B4tkQZDJU2tZ7pUk+wOK8gF1Qs61LcsNIA8I6jSC
	 TkDBirTYg6a5vNBOCsN13I0a+tLtgxXK5qVM6ze2xEzR3U5Qk6nIkcTfLBqqFqkxvk
	 Pn74c4vKHy67w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96A9FED3F1;
	Fri, 24 Apr 2026 17:39:23 +0000 (UTC)
From: =?utf-8?q?Nuno_S=C3=A1_via_B4_Relay?= <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH v4 0/4] dmaengine: dma-axi-dmac: Some memory related fixes
Date: Fri, 24 Apr 2026 18:40:13 +0100
Message-Id: <20260424-dma-dmac-handle-vunmap-v4-0-90f43412fdc0@analog.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNTQ7CIBAF4KsY1mJgoLR15T2MC1oGxdifFCWap
 ncXaowa08UsXmbmeyPxODj0ZLsayYDBede1Mcj1itQn3R6ROhMzAQaKCcioaXSamsatuSANt7b
 RPS2kZsrY3HAhSHzuB7TuPsP7wyv7W3XG+pq0dHFy/toNj7k58HT3LlFLJYFTRisUKJW12qpyp
 1t96Y6bumtIagnw7eSLDkSHAbdlZhkWefXniI8jWbHoiOiAzJQ2UALP5I8zTdMTDW94kl8BAAA
 =
X-Change-ID: 20260325-dma-dmac-handle-vunmap-84a06df7d133
To: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777052415; l=1159;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=xZL6Q8zEKVnEPzDpoBXi4fY8xiM5sA7I1SfhLEzZKX0=;
 b=JKSeLtIo/vPqAO6NN5tYwb+qVSO7rPZFygVH2lNQM1plz3wgkbO5ZoPrel5PuVLNbkQlWpr3U
 GGpJPym9naYAR+4G9SdceW4y2qCxka3zA8bCCQ4fmGhW2/j+BWGp3zj
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com
X-Rspamd-Queue-Id: DFE5B462099
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10118-lists,dmaengine=lfdr.de,nuno.sa.analog.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	HAS_REPLYTO(0.00)[nuno.sa@analog.com]

Here it goes v3. Given there are some discussions about adding devlinks
in damengine, I dropped the patch implementing the .device_release() for
now.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
Changes in v4:
- Patch 1:
  * Commit reword as per Frank suggestion
- Patch 2:
  * Commit reword as per Frank suggestion
- Patch 3:
  * Commit reword as per Frank suggestion
- Patch 4:
  * Commit subjectreword as per Frank suggestion
  * Added Fixes tag
- Link to v3: https://patch.msgid.link/20260408-dma-dmac-handle-vunmap-v3-0-2456ad292154@analog.com

---
Nuno Sá (4):
      dmaengine: Fix possible use after free
      dmaengine: dma-axi-dmac: Properly free struct axi_dmac_desc
      dmaengine: dma-axi-dmac: Drop struct clk from main struct
      dmaengine: dma-axi-dmac: use DMA pool to manange DMA descriptor

 drivers/dma/dma-axi-dmac.c | 77 +++++++++++++++++++++++++++-------------------
 drivers/dma/dmaengine.c    |  3 +-
 2 files changed, 47 insertions(+), 33 deletions(-)
---
base-commit: b7560798466a07d9c3fb011698e92c335ab28baf
change-id: 20260325-dma-dmac-handle-vunmap-84a06df7d133
--

Thanks!
- Nuno Sá



