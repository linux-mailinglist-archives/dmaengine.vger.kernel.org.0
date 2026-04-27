Return-Path: <dmaengine+bounces-10141-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GU8JFSa72npDAEAu9opvQ
	(envelope-from <dmaengine+bounces-10141-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:18:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 728E6477131
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 19:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3F209300C006
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 17:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030C73E3C5A;
	Mon, 27 Apr 2026 17:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dWIdgH61"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A0631B82B;
	Mon, 27 Apr 2026 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310275; cv=none; b=XaoOrR2Ja+PAA1m+bZeyUPtkPeBkOMbXCEXQer/8AA8hG6bU3ZuGKS2Q+VX2UPgo7/9/hF0DYjXKpaYNViS+HAeAaiNne0xl7PM3SsYiVivTqiM4/KfFGpxoCKqwo5UPeiZbhbqnytFaiqru7LCl9ng2+3VYrdY/ROXAR4sQFwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310275; c=relaxed/simple;
	bh=W5kkD2qOaf9p6y+JEmiY6YQ2keZoelr0Bif5djAA9uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTohxNhSmoZ211/BZ98jHlhAM9hP1Qs33KIcX24lIwwbWzyxD3kQdMtCC2DycZcZ00Yd8Nqq3ZYL83DlXGUvGLqOWBC25EmwovXaDta9IxHSTOOJM8sNUlimGj/hyBlD/oxNuDzpPYn7x/hD14pLY0WGyfb6suCYPjJIYfeMkAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dWIdgH61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B91DC2BCB9;
	Mon, 27 Apr 2026 17:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777310275;
	bh=W5kkD2qOaf9p6y+JEmiY6YQ2keZoelr0Bif5djAA9uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dWIdgH61f3FZjJK5/4M8qA2Z3PdTv2PxzuZWcauBhk9DdVxbBkauIdrH8T66hguCp
	 RKByLYUodinjcBlbYhttuH2LGK1CACi5Chox46drqrLCValqYMs6iS6hvWfa8xjP86
	 SRX8mzMn7HjzzZ5PMWVnIWvrJFLR/iyEIDn4Oi2BFSrDeboqSnIrX7WfhL6Ub+tY2g
	 I0hH+wNzy6c//f0TkDzcuax+fX8WXY8rTh4FJ51XM25PFd/tzjClOdpIOdXk4NjGqA
	 oBIlgUIOAdKFgg5RvdKRR4Lqk1Q+lbng1I1sXXDqtORIX/zFE6g7Yv8vrz97KbzGDV
	 XrdmpG3tF9W3Q==
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
To: Yury Norov <ynorov@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	David Laight <david.laight.linux@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	kvm@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-fsi@lists.ozlabs.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-wpan@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-serial@vger.kernel.org,
	linux-usb@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-fsdevel@vger.kernel.org,
	ocfs2-devel@lists.linux.dev,
	bpf@vger.kernel.org,
	kasan-dev@googlegroups.com,
	linux-mm@kvack.org,
	linux-x25@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-sound@vger.kernel.org,
	sound-open-firmware@alsa-project.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [RFC PATCH v1 3/9] x86/umip: Be stricter in fixup_umip_exception()
Date: Mon, 27 Apr 2026 19:13:44 +0200
Message-ID: <9e8e43d4f81d8f8b6f68311f1c6f859d718d36e4.1777306795.git.chleroy@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1777306795.git.chleroy@kernel.org>
References: <cover.1777306795.git.chleroy@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1000; i=chleroy@kernel.org; h=from:subject:message-id; bh=W5kkD2qOaf9p6y+JEmiY6YQ2keZoelr0Bif5djAA9uo=; b=owGbwMvMwCV2d0KB2p7V54MZT6slMWS+nxnda1Jdur5TX+RgO1P4hHufdruHR358Lz3BYPORx G8pRRuZOkpZGMS4GGTFFFmO/+feNaPrS2r+1F36MHNYmUCGMHBxCsBE9kkxMjTtX+zW2RH44ELN UZ/TjtH3Kj+Uzdh01e2y7qEZTgrchx8y/E9kjcpJ3dj/tNZwXUT0XHGmyS9k3dX75mj427u7JaY VMwMA
X-Developer-Key: i=chleroy@kernel.org; a=openpgp; fpr=10FFE6F8B390DE17ACC2632368A92FEB01B8DD78
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 728E6477131
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	FREEMAIL_TO(0.00)[nvidia.com,linux-foundation.org,gmail.com,linutronix.de];
	TAGGED_FROM(0.00)[bounces-10141-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

fixup_umip_exception() calls copy_to_user() and checks whether
the returned value is strictly positive.

A subsequent patch will change the return of copy_to_user() to
return -EFAULT in case of error.

Change the test to checking that the result is not 0.

At the time being copy_to_user() return an unsigned value so
'strictly positive' is the same as 'not 0'.

Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
---
 arch/x86/kernel/umip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
index 3ce99cbcf187..dfff28ea1dea 100644
--- a/arch/x86/kernel/umip.c
+++ b/arch/x86/kernel/umip.c
@@ -409,7 +409,7 @@ bool fixup_umip_exception(struct pt_regs *regs)
 			return false;
 
 		nr_copied = copy_to_user(uaddr, dummy_data, dummy_data_size);
-		if (nr_copied  > 0) {
+		if (nr_copied) {
 			/*
 			 * If copy fails, send a signal and tell caller that
 			 * fault was fixed up.
-- 
2.49.0


