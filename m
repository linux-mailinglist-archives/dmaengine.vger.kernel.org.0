Return-Path: <dmaengine+bounces-3327-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30611998EF9
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 19:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59114B2A154
	for <lists+dmaengine@lfdr.de>; Thu, 10 Oct 2024 17:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D04119D078;
	Thu, 10 Oct 2024 17:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFT4sPoN"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1194619CCF4;
	Thu, 10 Oct 2024 17:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728582739; cv=none; b=M9q4WTyqer/BSS7ghRmvuQ632idC9JXT2R+JPDysCTOTWn6b/6LDkHR7w2iUjSSsvhdozFTVtxCe8hCnsZGKtcCQxCe+cElhH0gxiXYUK9JIBf5aENcDalKIkBJnW1Rx2jbLY2AB7DOyiq9+eIQLKVAeHSdAsdartkViGyPF08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728582739; c=relaxed/simple;
	bh=ddiIgXOukM4wZqhv8wcNPf5q4K9xFXwkgPf0LtUxuVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=NnzNanMy23MU9AP3ye/9s1h6eIah4j1+CjfOWF7ol1v8tDIGYma01hWUZFyCa8UxF9y6fCSYFZQK8rmCGhBylqBfUJqoVW5iu+E+jb6iB2FHJEx3zOw4nPor2rhY8cGZRYUaqHn7AI7zsIYUnaJJ8Ro4VQ2s4hy9nzegm7uJy5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFT4sPoN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5E39C4CEC5;
	Thu, 10 Oct 2024 17:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728582738;
	bh=ddiIgXOukM4wZqhv8wcNPf5q4K9xFXwkgPf0LtUxuVg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=VFT4sPoNWAEyqXbXT2vcSPVpDbc7zIRVrvDeNCc/hriUtDptWkb7+0qqK2KLUm/Pg
	 K6XCPpkQDDnhKdT5+GGvy8MIPiX34onxIMJrCIaz2uTmUSdP+TtUe2l6hakSNwsqQZ
	 iCwXoSkYYqwQzxcXh4KRgXH/Qb74KLGMC5/leajTSIymmCQ+0ybJVZUtq5fKXsCE7S
	 Yzpt1yOe8IZTfKpn22y9otQdSe12w7hQ+ChHhlhQq1g0jinKHA6D5yhROLdgPGoqXb
	 HktVIgSdLwr637mqalxqP2kWUjD6Ik1B9bkOw9CKKaB2HAbDXnAg/LQ78Vi0nPoGT5
	 Zxp41d9ggUsxg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904E0CFC5EB;
	Thu, 10 Oct 2024 17:52:18 +0000 (UTC)
From: Nathan Lynch via B4 Relay <devnull+nathan.lynch.amd.com@kernel.org>
Date: Thu, 10 Oct 2024 12:52:07 -0500
Subject: [PATCH] Documentation: dmaengine: Correct reference to
 glReadPixels()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241010-doc-dmaengine-glreadpixels-v1-1-8202e5834b13@amd.com>
X-B4-Tracking: v=1; b=H4sIAEYUCGcC/xXMwQqEIBRG4VeJu+6CmRPVq0QLR//sQlkoRBC9+
 zjLjwPnoYwkyDRWDyVckuWIBU1dkVttDGDxxaSVNo1SA/vDsd8tYpAIDluC9afc2DL339Z8tOl
 6OE1lcCYspfzn0/y+P0jULq9sAAAA
X-Change-ID: 20241009-doc-dmaengine-glreadpixels-8b3452468ec2
To: Vinod Koul <vkoul@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: dmaengine@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nathan Lynch <nathan.lynch@amd.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728582737; l=1424;
 i=nathan.lynch@amd.com; s=20241010; h=from:subject:message-id;
 bh=sDI7N3mxHAJ03TcvFpl2PcGzAZf7bKpMalFWT9iQmv8=;
 b=C2kVbm9G0oEK8V8c2YVh5mkgs4l3JJMx87pC6fK6biBfp90u3cCU638A9FdaIo3IPPlGudriY
 3Io0jApTASJC251tjhjmU7+fLufEo7UYd5bGXz14PqV2J98qNIQYpzn
X-Developer-Key: i=nathan.lynch@amd.com; a=ed25519;
 pk=ZR637UTGg5YLDj56cxFeHdYoUjPMMFbcijfOkAmAnbc=
X-Endpoint-Received: by B4 Relay for nathan.lynch@amd.com/20241010 with
 auth_id=241
X-Original-From: Nathan Lynch <nathan.lynch@amd.com>
Reply-To: nathan.lynch@amd.com

From: Nathan Lynch <nathan.lynch@amd.com>

The author very likely meant "glReadPixels()" instead of
"glReadpielx()", which does not appear in the OpenGL API.

https://registry.khronos.org/OpenGL-Refpages/gl4/html/glReadPixels.xhtml

Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>
---
 Documentation/driver-api/dmaengine/provider.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/provider.rst b/Documentation/driver-api/dmaengine/provider.rst
index 3085f8b460fa5514bf95d07e9c7120c19f2d467b..48ad4fd6e2773ab4e4ca5bcb851c0204295ab56f 100644
--- a/Documentation/driver-api/dmaengine/provider.rst
+++ b/Documentation/driver-api/dmaengine/provider.rst
@@ -172,8 +172,8 @@ Currently, the types available are:
   - It's usually used for copying pixel data between host memory and
     memory-mapped GPU device memory, such as found on modern PCI video graphics
     cards. The most immediate example is the OpenGL API function
-    ``glReadPielx()``, which might require a verbatim copy of a huge framebuffer
-    from local device memory onto host memory.
+    ``glReadPixels()``, which might require a verbatim copy of a huge
+    framebuffer from local device memory onto host memory.
 
 - DMA_XOR
 

---
base-commit: 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
change-id: 20241009-doc-dmaengine-glreadpixels-8b3452468ec2

Best regards,
-- 
Nathan Lynch <nathan.lynch@amd.com>



