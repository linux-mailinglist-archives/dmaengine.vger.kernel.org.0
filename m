Return-Path: <dmaengine+bounces-3578-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F08E9B003C
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 12:37:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF6C01F222C0
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2024 10:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC011F80C1;
	Fri, 25 Oct 2024 10:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="jUodZzfv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D61D8DFE;
	Fri, 25 Oct 2024 10:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729852615; cv=none; b=RMrKZDppmItE2XgHnvuXR/yehKld6Wm/l08DVcV2HtPwjsG8SsfJrFVjb6pkGcnEukhZrgSapkSm+BcluvacQZTs75HK9qSbgB3s/4IgE0pqaoe8u5oBiXv1TdM/YTq2a5ET2c7/uU84wHshNOEEarJaXZl2oyr6sPkzYUXy0c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729852615; c=relaxed/simple;
	bh=M2oHeB+WOJwn9JLMEYWUmv8S51I4OUTUIuKP3pPKzws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EwNMFW8ca3J3y2Ov0/SYI8LlsesF5OODROV8QjPmr/k/s+JXBJSeFGvznGbMgS9DCYFtlgp9BWoTAbz5ceBAfs38IFynJpxz6hxwcq7vWoKUCOAIfifsLojcbpy/eda/FcPt6EXtNZgeb/Qvh1qjZKQbHlSV3UDBxiCcQGha698=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=jUodZzfv; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1729852591; x=1730457391; i=wahrenst@gmx.net;
	bh=v+14rsoDnpAU5TPVahAWZNaZb+eP4NYQnwXlsAb9tek=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jUodZzfvzwpiKmlGXMpLSoH97D1zgHwHbx2V8+KyDn33tgz02c+gDZh99XogEztY
	 R003ScT7z/RhrGoNxalshdjIL2zs2CY3wAqrH/+Jiwz1acnDDGrf8I4QtT3If1+JY
	 HFnXWGgVZ3haIqwU51Iir/HujzNaCM1WKe/PHiBQm4UQsql6l/xjNpO3H8+UspMGe
	 sVsAtUVvhp+6T7/C8+w4rvL+Zz2xtMnxFGqQhihXbP9I+23DX3M5b5QSQ54yYZLHj
	 qQDrbp5dkgJOFcd+dpGptt+TAzm2G4Vgx5r/jICpSnFM8Fx7QX5Ti9uKXsBK3xzwt
	 vvu/r6QgH1MTSXYgIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3se8-1u3uk30fse-00rpzY; Fri, 25
 Oct 2024 12:36:31 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Vinod Koul <vkoul@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Peter Robinson <pbrobinson@gmail.com>,
	"Ivan T . Ivanov" <iivanov@suse.de>,
	linux-arm-kernel@lists.infradead.org,
	kernel-list@raspberrypi.com,
	bcm-kernel-feedback-list@broadcom.com,
	dmaengine@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH V5 1/9] Revert "usb: dwc2: Skip clock gating on Broadcom SoCs"
Date: Fri, 25 Oct 2024 12:36:13 +0200
Message-Id: <20241025103621.4780-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025103621.4780-1-wahrenst@gmx.net>
References: <20241025103621.4780-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:LX+8Udr1Qy1uJJyzFF2uxnDdg+ofpa5QFQ9ka+i+Kss/gycsAWe
 3hnFUfPesfEL6STIaHBvghNzUsjux7yOLBTHROg5Ou6oA47ndq8Qky+rBig8N7YHkTfUD5b
 ht97F0d7YpMKBUucH+BbCv8Xd+k8hfoaESvplXfnz9l79u9VujuvFW5Dot/+++6XG2X2Eq5
 LtQGX0miVmZdeXO9OrnMw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pfc7vnUSVxM=;gwkxqYXBNhdax3MuMrQlEjY7i45
 036JJjqOSkCUD5zDxCWaErzpJxPMnT9TrHdDa+DCI53WbazV7FYrKTYkZ7oBfamflLDpRzVtK
 LfXrq06m2k9Mh5g7wy7Pf+wK5V5jpVdYzPQ99pJ/ggcMJbIZu/SNtLxEQ8WzQ/slXChQgsgQ8
 suoXbq/OmErwpOxjTC9BVMHtKTEHCmyQfzBv+YeHNn8QL8ApNjzDFipKN9WLAYvEPt4I61Edz
 so0NVLguBnfgxPy3T8a2EtTgDkqAqIu1bIS3aMAAHKpZXesnZFYTsYGUG8PGgR9fzi5X1hBFw
 3k5bvXrNqmrH2s3GO3MHwV5Orka00TmSRm7Z2ZXdwzUxG1a4dLauClNH8QsLL+yW3ZTu+9yT0
 vfgPdETTvACNeYcOiBuK06pc0LQk9nN6v7DiDYsjEqOoINjnQwpI2HF0+/AwHwgxQ8kiQTuQX
 uMEBd7g9AuRBp1gwFn7in3AIvTzSmgWgeR4kC1qjOud1oHs+OzSxPv7RFal5FTatI62jpTmWo
 VHm96VD2OkTtkrqBDHSPJ7tiU8gSjo4i34Aac0xD0GJxeFt0p3zIJM75IfwWDpKTF0K65gtB/
 xc32PBNUJQ1f9w9gnHdqTL3dihNf567SyGeMi9YHn9LRPDV6SG8ns/2c6UB5nqjuUhUk/wa0Q
 5fcbmCnAAuPmhdB4vZ2gqBS5BKNmzTKH8e3IQVrZjLykpwBrPz+xCmopalI0IHB/3h8C7bU48
 5//Rz4iFHJmAaKbdra2Gr4QJndlNqnMBbG+DoGIofgsSJnVhPegT8j2BwRXSag8r1lHdIxxVY
 O37G7ccRpwJuNiB8yGwPUeB/hGi1SDFrMsuR4boMQoSPU=

The commit d483f034f032 ("usb: dwc2: Skip clock gating on Broadcom SoCs")
introduced a regression on Raspberry Pi 3 B Plus, which prevents
enumeration of the onboard Microchip LAN7800 in case no external USB devic=
e
is connected during boot.

Fixes: d483f034f032 ("usb: dwc2: Skip clock gating on Broadcom SoCs")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 drivers/usb/dwc2/params.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 68226defdc60..4d73fae80b12 100644
=2D-- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -23,7 +23,6 @@ static void dwc2_set_bcm_params(struct dwc2_hsotg *hsotg=
)
 	p->max_transfer_size =3D 65535;
 	p->max_packet_count =3D 511;
 	p->ahbcfg =3D 0x10;
-	p->no_clock_gating =3D true;
 }

 static void dwc2_set_his_params(struct dwc2_hsotg *hsotg)
=2D-
2.34.1


