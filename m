Return-Path: <dmaengine+bounces-1124-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DC2869C56
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 17:38:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031DC1C24BA0
	for <lists+dmaengine@lfdr.de>; Tue, 27 Feb 2024 16:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4940D200DB;
	Tue, 27 Feb 2024 16:38:15 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826471F61C;
	Tue, 27 Feb 2024 16:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051895; cv=fail; b=WTFXBXI+qic+KOocTSNfyA1RL14Fj/vM6k2OBc5k8Krxu+JvrODpzyIYr79olm+eH1QFYhtnp3hk/1ZLeAT63Lf4Pc6NwE6oA7My1vM0Iib9SVCFScOYHk8Sjei/mJo1ZzmNZjy1GN8ybD8ICxemJKwTSueX6cc7TMCouO2sT2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051895; c=relaxed/simple;
	bh=asem7D2d3ie17mLaIhy+1kEiIEcNR9D58UV9tfBd3YE=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=H4lm98Domn7ozjPHvygLYphms+90i2VAFKcHdj8/+CctcdCEKvED8NRbnEKqFKeOmHfnbTeToIEytKt6eeq5muQslY3bsGiSin+TP6/JKM2J9TjsovpGPeV6mZU4aO0Er3kl2m8Cd/BX4MhP34RWuSL8WpUMp54EJFJOuCjEHIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zkxp2/uuKvRoiupzyTRRkgc73ejpEOaZZqjqxn7N1DTnu7LtCxz4jWvd/71eCAZtlj+5i2GDRSNDFHaY5mxwJScFJXdFJVw4qxlaRoUd8IHGQd7cuq27pC7vD/74UmhVehSW2IfWNzz0ns/67OKbU+nxleWU1Y/XksQMOmibvCmiPuqkNOfqBBma3H8QXc4ar4FZaaH0gLHYoE0fi09P53lj1TtdA7yHZFklRxM0NR78vtOs2SUcYjRr1/4wZWs66WKo823aIHqpzqGf8gosZpWxYXuSOnDIxl2/K9W9ZVIJ754/4f723uE69HU8T23tbhpsZffaltNvcaPJ7VMScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hYx+KSEMw1F+aSAH+9sIPjRzNNgvs+xXHPlRNX5ahkk=;
 b=EdFgG4PS9Op3EPeQpOXOxJFLOhxtlv+/shEffgxOBCnW1SsDvOSVDCUz7gneK+b70nYImfl91zTW7IPJrVQamsi1AdiDSzRuMcANqPfUV4uYkrsXxHix3ToS9gxDJhrZiEOZn6MOZtV1bYsBXJ4uamilBnRvJmtPMBj7V5LApQTI2GXf7u9Uzkb22/ifoWzg7j77kYGAvNABPQwqa40PxZPzMizaGHKVfR6JqcwxPy3CNdvNuFuMQULBtk+eQr9KEfKSBRh6s4LLiYozJLfLwawO8Qhesna6S3zXJXS4oee++vcGZ2Y2eChcuu0Fhzd/jhjvpS70AV5jcf0c5NkdGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0685.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:27::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.42; Tue, 27 Feb
 2024 16:38:06 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 27 Feb 2024 16:38:06 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-crypto@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v3 0/6] crypto: starfive: Add support for JH8100
Date: Wed, 28 Feb 2024 00:37:52 +0800
Message-Id: <20240227163758.198133-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::16) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0685:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a3be24e-a843-40f7-b9ea-08dc37b279c8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FCXfHTR45J8dG3rzVYis7q4AoDYqbMHKU0nJHEUf1oMDTb2GZDKIhdvBzY4owLWPwyh16PiGvPQbIxnVhtV9AW46PcxULQrTQmWl9Fay2ovW9vzn0KyxcWRkyc570JiU6oB2ePOLyLPEfyeytTETSh4Z8og35WBRG+4rRpM45R0Nh0Bp6dL5dSawzNIAkcK2n5Idq9j+g90BMCYV91TRZuoomIuoU7b2XyTxv8EV/z3BlLDrWSWkckKbWTCb8sgmYqrZfU67pwMcCSKDVQipNAGFq8vADaQJg+j8nHuCAlkKORy9w4y6AZ34+jsEzod9ijf9ExpKfSM3e3zzPUYC0H6s8S5WEBSHk/eWRaKUKvwJmW/j3yx0CPOMdxiMf6sd04NLAnq3ezAV75AVae2fPBhXoCZKgh5RYfQLo8XqCMoLY8C8/dTp3jkqbq3EiWm5eWfpvws2st7hr4YzZrkdZ/+06EIJ94vAW/A3wtSBKnUVr3XMsnhFF+E393O+MKhnJn0+p9/FRygFd6DlDLVG+LexGRmK+sFOui/GGMCzB5VjTcrZrkvNMTQ/tkSLFXegXKhURQTchK/Udt+M5IdDz/fxdA+K+gRshx9YrpKvu1UclcQYdal6PSkx07btZOgb7rYuEIyoouYbNwFT3zn3kQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sZ9SGh2enYt+kuCIennKLes7x3DtI+dWfhYkL4Bg1mRrX8MyPoJ+8aO0mqMs?=
 =?us-ascii?Q?we4MYJSjN7fgMek53fE1chnyM/jOH8MiAw1mn2DFFB1/hTkw1fNBbpMEkOJy?=
 =?us-ascii?Q?4cxUhmHjmdvZTA84C25Uu7zkWoJZv5mfYViSPstZiVvgxTosobhxLhXQ3+it?=
 =?us-ascii?Q?n08UqPDmvZgyBmopLvSB/69Ac+1ChD8dF+VEpkxYlGtKubunsYRopZc5dbcW?=
 =?us-ascii?Q?PF6ShU5HaPsWPoXm29IyGM7WRjUR3JD6KB/22n1u6NMye8QyPkjYHZe6bPvN?=
 =?us-ascii?Q?FYI9YHHXCJeFbYeQM9Nb0d0XhjEp1Zo3mxLNgcWyeXPcuAaOpqsvWnJthmNg?=
 =?us-ascii?Q?svBbsS636RsvNuhOksUX8RrowxJw+WpCuBZu0G3wC6+cMbVB5pbTFV411hq2?=
 =?us-ascii?Q?V19MB/omJC0xHzbwcXGWrIz2PEcg1SzgZLefEqKqUBFrloB+Q/XK7/bUYLf8?=
 =?us-ascii?Q?bE7Lm+BGL+sB7WCy91NaBmy2I5HQnyQ7o51m4KHTdr3R/NWOJvnRIEdm5K+w?=
 =?us-ascii?Q?v6j0cTLTALVi47JqFSJexYUPRc39NzPjVnoLz+Qk8BQJTDH+n8R+fjQWASiG?=
 =?us-ascii?Q?r0zv/eVwfcBvyRh+jtOwUiq/T2jNE1eyiGmWRpzaI2O39TXJGStoQTMfPs9S?=
 =?us-ascii?Q?AXpneWEr65hLPN8KPxP0xeC687pHN2MYwlsA4ls0D8dw/1kz+smZyHNLiwXt?=
 =?us-ascii?Q?qN3sbLv+CkKRkU96ptKu+KfsIurnmCK9NZ83OIOGqfOkp3E67KLbe8QKg+zn?=
 =?us-ascii?Q?s0wIRfBeAKtyOjUCGQEPnfHoYnOKuac5DDbVGg9eK85KZ/kTPFKYPsQq3336?=
 =?us-ascii?Q?V/7DoQn6K4Tw/Samvm7bhjqM8xw1EREE5dHgt8aOJn/dBb3EaVeKalPds5T1?=
 =?us-ascii?Q?TukdpLZQavQ2IA3kNGxKTwKPinsPThrQQ+xJsRxvR+RcTmdsWXcH7VwEGqc+?=
 =?us-ascii?Q?PZznESdxo3CND2s9uczg9hE0suxgQRV8eZCz9Btazte8mMYLr0L/v8MR9yxr?=
 =?us-ascii?Q?C58bwDXW+/bmqv/9HQRs/LXynGkgdyGv0bcjGzzsE3y839K9AYvrlGI10l+I?=
 =?us-ascii?Q?dXufi0QyDMb00AmZ/B9ZKymNiojVqFklo5BGzKuNM7nk+z6ldyU6op/71K/Y?=
 =?us-ascii?Q?9Qyr0S+CZD4WBoFAHWj05jgyPf+zLXKQ0ryviOdS5DYq59q7oQ6FGsceJNJx?=
 =?us-ascii?Q?twXHCcajSJc880dH9GApF1BTRvsF27cEqgo3UOB+bKNWSE0w7nfPGOJMLC3U?=
 =?us-ascii?Q?JHnhl4iNbOzFnRNrEHu2QgL2UnJy8ULigssQMqbD+dWHASele7HnmCJ24eCF?=
 =?us-ascii?Q?K+a679QQrKFl7dOWr7EycAhkDnh5p46HbL633WtdwqT4K5PO0t+aPuHU8AII?=
 =?us-ascii?Q?8cEJRhInoP4KFDIm6YcPdmtcsS7hTW5sjWRvieuBzoIXjdY+lBDxYFa0jpU+?=
 =?us-ascii?Q?FZmYYN1VRGEPMYI0q2W3N6oSxtDlpB1U9g7EcbtzHFvrZm7+vOF5fadhMsGT?=
 =?us-ascii?Q?qwQ/NOk68LlEpFbpqwUs7Fz+wS9S3sInc49XZCKZqkbYQcIXma+AzYMwdIuq?=
 =?us-ascii?Q?DOc9D4ngMyFWFBRSrqzrp25TUP0eOUo0sAnBGOjDf53NAd1UE+btK2DKudxi?=
 =?us-ascii?Q?Yw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a3be24e-a843-40f7-b9ea-08dc37b279c8
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 16:38:06.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 13xJdarasJkVp3+8euyuToQOwusClArFxklVhZAKQzqbwGZ9ltHQu7xBeVKporzI8Knkgjw4TBvXT/0Z2sY+O1e3m3y0GIQ2MshYszeXPjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0685

This patch series add driver support for StarFive JH8100 SoC crypto
engine. Patch 1 adds compatible string and update irq descriptions for
JH8100 device. Subsequent patches update current driver implementations
to support both 7110 and 8100 variants.

v2->v3:
- Use of device data instead of #ifdef CONFIG_ for different device
  variants.
- Updated dt bindings compatible and interrupts descriptions.
- Added patch 4 to support hardware quirks for dw-axi-dmac driver.

v1->v2:
- Resolved build warnings reported by kernel test robot
  https://lore.kernel.org/oe-kbuild-all/202312170614.24rtwf9x-lkp@intel.com/

Jia Jie Ho (6):
  dt-bindings: crypto: starfive: Add jh8100 support
  crypto: starfive: Update hash dma usage
  crypto: starfive: Use dma for aes requests
  dmaengine: dw-axi-dmac: Support hardware quirks
  crypto: starfive: Add sm3 support for JH8100
  crypto: starfive: Add sm4 support for JH8100

 .../crypto/starfive,jh7110-crypto.yaml        |   30 +-
 drivers/crypto/starfive/Kconfig               |   30 +-
 drivers/crypto/starfive/Makefile              |    5 +-
 drivers/crypto/starfive/jh7110-aes.c          |  592 ++++++---
 drivers/crypto/starfive/jh7110-cryp.c         |   77 +-
 drivers/crypto/starfive/jh7110-cryp.h         |  112 +-
 drivers/crypto/starfive/jh7110-hash.c         |  304 ++---
 drivers/crypto/starfive/jh8100-sm3.c          |  535 ++++++++
 drivers/crypto/starfive/jh8100-sm4.c          | 1119 +++++++++++++++++
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |   32 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |    2 +
 include/linux/dma/dw_axi.h                    |   11 +
 12 files changed, 2412 insertions(+), 437 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh8100-sm3.c
 create mode 100644 drivers/crypto/starfive/jh8100-sm4.c
 create mode 100644 include/linux/dma/dw_axi.h

-- 
2.34.1


