Return-Path: <dmaengine+bounces-841-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB24783F544
	for <lists+dmaengine@lfdr.de>; Sun, 28 Jan 2024 12:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA6DB21B0C
	for <lists+dmaengine@lfdr.de>; Sun, 28 Jan 2024 11:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5161F94B;
	Sun, 28 Jan 2024 11:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="nVl1GD4e"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17F623745;
	Sun, 28 Jan 2024 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706442779; cv=none; b=IHeN9//OB3QYHgFs1UEfz3syPJZBzVC5cK4SvACc7lScHxpIwvqXu29j1e143RLou4PoBTRvN59aAI9/axlJkUN0zOo1pIGEbHaZyUgMryM/xNv5aCpyXKNslleBAAY53BSzUdvkKGQ9ny4a3PF4SuCFHMMwS0WamH5263V+LOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706442779; c=relaxed/simple;
	bh=8qgAYxoJEnz0fBm9iJvQjJPfTW90lqM8TrpQVaYANAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iT011zMy6eRPGRvh4NAW6AAln1aAgEIIXvxr5UbNV2wZdXz2afuxzkwjgHvQdtp/VKG8UmsKl52GXgz3NuZBoXvhQkHrz9VvGxR5JbsDRcf3xXDD3Fnw1mpeBjCauuuO0Kb5suLdlxGQYGZ6ePGnYPZMOMrx/mjNvpFQCi/ij1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b=nVl1GD4e; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1706442770; x=1707047570; i=erick.archer@gmx.com;
	bh=8qgAYxoJEnz0fBm9iJvQjJPfTW90lqM8TrpQVaYANAU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=nVl1GD4eYpC6MnLtFA0UzYbsxUtHCpP4SFQ1CJzTGpfUzyEHjN2LB7T5RBvAhv6E
	 9RvvjVO+Lj8jkkSOrMC8OyWRn1rnPZgEXqlqiULjQA2WqB7m0eIeLdvIw01U55+hZ
	 1nEyHxiLWLSG7VJEywQgXu2102QMPYoOD5+2s9zN2sU6Kh4EZexqLQAxkgLfxRk4Q
	 Lt+dNk82L3IBmop+fEiiGRLpqk0fIyFudgajxqkzG1dCgDI48r1uuR9gqnpgCJA5j
	 DCgWrDNpSmxV6fy7xWZefyzG0zo0D44U1Y+9yaALoOkHVsE2fyNTHw4EgzkIjcXGa
	 GJlznFKSGIXxosN7Mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MA7GS-1rMxFg0ZEw-00BeIA; Sun, 28 Jan 2024 12:52:50 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Vinod Koul <vkoul@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] dmaengine: pl08x: Use kcalloc() instead of kzalloc()
Date: Sun, 28 Jan 2024 12:52:36 +0100
Message-Id: <20240128115236.4791-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RzKISSY/CLtSCejfdxskHKGt4rJ30dy5Yk/kNZCNg7MRaPI3vlW
 Nv5dbh5aUMKwYCD7ONlvAabEiHNdT3bBzs8znGkP/YKzHZWTg5zc/xBdx9ufsPuPzKm0Em9
 W6446vGNg0Y8Bxw5OCcPNCMjsXrVi4urUSEA/Vztze8EmhnzlP+ORc/IhLqnLRy3bYhXAoQ
 R9OokhH7JTaC0q4SHbbrQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NqWDpYotzqo=;YRCXAJOFtmujiztYMgzyJerwsJ2
 /VNB6fVwkBl5evt3pnh9L91ilk14Ne7edFPWUOJ4RX73VcxLPD9AjKqEG5usCnfLyykIMfZah
 L4qdB4Op1PvYUWK1Ro+lt/Qu2+uS6q1i3uJ6M+4pOjZRQ5/TltA5H6pDkjFYM2Or0yw3k/i3F
 bEpNSfCOabKffmwE13OCnNuQaV3MARhfwCPV7LNSqvR3aeyzuzSW7Y/ibLZEIzMUieVqA/nZ7
 BksZZnmMOAmiqDJxCKum3WKpGHC48dzh5hm6txYIUbhdZ3JK1a8PuSN/yG1GaFgIWjYMd7X8u
 ljVqvPrcIUzs8G2Io1oulc/XzRdx5j9pXIZCgphpHN7iHmYM0QWZ5PeRyJFpv5Iln9rTILm+H
 K1ZyNjAUyAM/WilEgE3sqLjZmTPo3tRijA+1pITz8Pk3HW7BivG47IfXu87/JOFZD/PQwaJEl
 KlvO7/UvFuxz4xAHOVX4JTkNRz2AmyVrdN97z4gUX3hV9SPj3wcVq8O4O84XBnOcvfgHckJQi
 SuGP8ez8oLMfHnewSQfpqSe1ss1D0lAIJSAcHjVEQ3x+dUTra36/6mb0WNKzJo5OuImr6gd2U
 gS5enXim+kJMv8FQAt4aMgFO3yBucLEuAdplCpIOB6l4RCxgDOWpBC1wguykKVCrmI5l8RCcf
 SR5tO8dAQfyrR435pJrKdKGIsb0TtMhEtVIKek7w3/6tV+R4S/uge0cp46lUfpxDwhkWhssot
 FLjR8VxSgNYk9Ctxk/lYJyhWaQY8SCXeowqf3cV/M0pmKboqJf0VmijKmHQx+38GFbJhI5n86
 epx6wOTa5eRHN5dc/Z3Hi1+F42rW+5W5tuXPaSvZ5FPU40PFcNic7XxQgTU1iNoQ2tiFJYjjO
 8KisukA11HOlrSnOz6C/svPsobWntEUOePplcuzq8jqgfEUtSId3DBoYqWcLM9W89w+9CNSG+
 1Xww/wifeRY2UF0NVIqEIOzLDyg=

This is an effort to get rid of all multiplications from allocation
functions in order to prevent integer overflows [1].

Here the multiplication is obviously safe because the "channels"
member can only be 8 or 2. This value is set when the "vendor_data"
structs are initialized.

static struct vendor_data vendor_pl080 =3D {
	[...]
	.channels =3D 8,
	[...]
};

static struct vendor_data vendor_nomadik =3D {
	[...]
	.channels =3D 8,
	[...]
};

static struct vendor_data vendor_pl080s =3D {
	[...]
	.channels =3D 8,
	[...]
};

static struct vendor_data vendor_pl081 =3D {
	[...]
	.channels =3D 2,
	[...]
};

However, using kcalloc() is more appropriate [1] and improves
readability. This patch has no effect on runtime behavior.

Link: https://github.com/KSPP/linux/issues/162 [1]
Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-co=
ded-arithmetic-in-allocator-arguments [1]
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 drivers/dma/amba-pl08x.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index eea8bd33b4b7..e40766108787 100644
=2D-- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -2855,8 +2855,8 @@ static int pl08x_probe(struct amba_device *adev, con=
st struct amba_id *id)
 	}

 	/* Initialize physical channels */
-	pl08x->phy_chans =3D kzalloc((vd->channels * sizeof(*pl08x->phy_chans)),
-			GFP_KERNEL);
+	pl08x->phy_chans =3D kcalloc(vd->channels, sizeof(*pl08x->phy_chans),
+				   GFP_KERNEL);
 	if (!pl08x->phy_chans) {
 		ret =3D -ENOMEM;
 		goto out_no_phychans;
=2D-
2.25.1


