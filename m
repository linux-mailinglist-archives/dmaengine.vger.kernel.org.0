Return-Path: <dmaengine+bounces-2210-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3FE8D4595
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 08:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B4A1C209AE
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 06:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2144C1586C8;
	Thu, 30 May 2024 06:46:51 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2115.outbound.protection.partner.outlook.cn [139.219.17.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49293207;
	Thu, 30 May 2024 06:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051611; cv=fail; b=udz9h3FJpW5Ldby7MNimtwTbHNPAZ+vw5dxHITxNkukPC2NF0GZPxzNBwf8iwHNpUqfXQvbi1+G6sZNiNPsXjUEq4kenObtr0BKfPBjw+ob8e2ulrvCX8TES3Rh2bnT0Rh1xTacTzk8TjRbg8U0HNDg52GP/ps7iLPG6eXD4MF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051611; c=relaxed/simple;
	bh=fjjWk8ndr+UmFoK4LzVFtpJxUpCINDlYUQ8/Gk6wqUI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=CH0rAds2tXWxBhjPQOUixvPh1A+igFfzVdz2lbpFS6JpSX3GEo2eoiNaojNsjwivaeCrLkyrI2qxNf+T1kiUP1XFQffcg+IQcdxfvlooiDWNite5egPK5HJX/6zYAybwcLdDUHMwgb5ohx9llidrqMmVtLiFRH5Oz/FBbgKE9CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jmf9WXv6b/B/aE/E3IhdgI6qkidk+mkV9HP74nYxhaLb0BSzL76rZEt3DvU5zJbmzDB+qB0wQln0HRsFmwKkB3/g2lsKOenNEyi+5Zefgf9V0bXCXmICo1Fqn6Ys0CcVWfKbBqMU5rOAbjLidUnEjvAkNYUPoXcNMvPJJu29hx6qtye3AqXSgEfQAvq4M7KZr2q0XxPCgtcHGtmK2dqamYpd1WQeC3XytYeeBsb2IQ+X59BFljmEb20qMPzgMAHRapi+/MR+Hds1Rye3CJ9UeWqVQKqBr+wnRxaZZtFli4OgGM1sD/DTliEqlJdDD6etYh+9BffVjtlNVqTR2jonAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=daPUXex62SYqgy2tU010SjCFcRcRoJ7Sym1Zgx0P7Xo=;
 b=iRPuQauna8nqbkPmvOItwqPdS83xlP2C3ala5Eo2ww1AUEXmeRBw/KQo5gPyLQY1M39C8hycN+qsd9EIil/nFOi+78VwSrdZ7MLIdaM/MMtN83w+36SQiPTdUvKf3dxEbxTihggNR6NuRUNYUuGAOE77sYniZPilsOQzwOmygMxXfKOg7B1vM6SXSXr14xcFL6j67ikKa8Ac0g6zByKz9dPEm4SIYQlc/p0UyZpawlOrtLf3sZ5l4zfZWDM9xpakbaUXzMWBdq6yYBh3IpTTmPDh5QA8DOl81/tpdYI/5e0TYtaObTimgAR5d1KCWoxl4Eb5UpYR6wDJgFzhJnRSpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB1054.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 30 May
 2024 03:11:24 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::e3b:43f8:2e6d:ecce]) by NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::e3b:43f8:2e6d:ecce%7]) with mapi id 15.20.7587.037; Thu, 30 May 2024
 03:11:24 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 0/3] crypto: starfive: Add support for JH8100
Date: Thu, 30 May 2024 11:11:09 +0800
Message-ID: <20240530031112.4952-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0027.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::17) To NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1182:EE_|NT0PR01MB1054:EE_
X-MS-Office365-Filtering-Correlation-Id: b3647e40-5935-485d-84f2-08dc8056301d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|41320700004|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	JFLWT9AWmzDmTnpEG+1gz+HQ6YkM6UorlMgjHWb9U7TYRlwC9zmNaGz23FYVwuOyEMF474/tf5flS4LH5Q6sJsoUOCJUeWX99Vkjpe//89IrG3RIzIPqTInTivpZtr37HnfQkd81gf4oxlCtA7MRtJoDwYvEEgJYqxRzRsUp6K6g7d0gnDJE48Kx76CWXY/L1KdmHuRIC2G1e2ZdkORcJdEvdpNRKdeBXQqGqWMAFOcK+hcJczDIupNcJUvriRLafZBpOeKgTn3waDcXhRMEQgPYIlXdG6hb8wb9MkP2Bh8GQoNWyyWkf3EgJMizoMLCluu7+JqXEovZLd24L00RKYztkKAEsKF4OFliCWldsVFN2JtlBxrK/6q1njotAICHn8EPMtOL1vKhTCjM8JUhWzP8FC7O5miyOHfK1vBNMd7lBSGe9fJSdS3x/DuorUlDkYgB2hFEoZcdZwANYFjl37xAk5Crnu2K055ShMiLUqpeGmFV8b6R3xTJUVkdAQYbVk2ftB3nm0FjJ8mfUuO0WfjkVw79Q6DChbDk7Bubc1kyz1WqLIYy7JRFKP9CTwNoZ0hWG7/ESKqfShICGcSmfEeqz+IAVmMFlJMUptG9bTCbsb3ioo6sTAwA/SI+ZPzx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Tpxuvf+wBEdR5Fhiouh4gx2TlGFvdNZtms8sz2hYLjMeSk94WvPYLzGEnkH4?=
 =?us-ascii?Q?fjohxfMmurWZEvnRVV38h/0pcqKxlHyVlZ+DMpYBirqrqAhv4rpl2oGkK2q+?=
 =?us-ascii?Q?coK4lp9fbmelUtkm97yePNYFWCPs395PfoKzjeAOKyQXzQEaZM0UdnAKLW2b?=
 =?us-ascii?Q?niQ4vH2QOPNWKCQe+DE6ZfJxt2v/atJK96tuJKwrQ2LfWA44SPRDiJ9eP87R?=
 =?us-ascii?Q?8i7CVv2t11iSSyReRcMgheSiQkzeiCDjR353zDtt+rF34EnUImfkkGd5PFjb?=
 =?us-ascii?Q?nyHXMfRHG0kvaQxbaG6UjRIxCPUKIVHPjHO/ukXSwVOaKdp5ecPYQsggWOnV?=
 =?us-ascii?Q?Qi8G8h2Qe2u6HLHZI6JSOfRXdqJ0oaTsdMpMIuhY5QyNEi2cRXb5jpS6cG01?=
 =?us-ascii?Q?ebHYVr+suaGvzQlOQ3eGSFDwHS3iubvfXK3+JNFTF+RUSRFdYb8Q8vhne+UJ?=
 =?us-ascii?Q?xDvJKoEGjo7nlH1IBasGtIoAxV7/HyXXYPK+DySJH6I4/hiCvODUBZFuXJRH?=
 =?us-ascii?Q?CfIw+U5GygC33fhh7IyGio5l2SEJYQzwEHrtfYXiK8ZuTdZoyitXBZslcUHa?=
 =?us-ascii?Q?PlSPIuAJ4ipIiVnrlX7NkxzW9w70XS0cjMsprQECRONVv3WmJsgZgXl3lryw?=
 =?us-ascii?Q?+XNIZJFjbOVCPsRNpeyPTqKAobuGJT/4sJB1nDSe58aCPb1xsUlS9XlxOOjO?=
 =?us-ascii?Q?Kfymkh3pkOvEd1SO3vtPzcjsGkHN+EsQrm+wFl5xCbSg4pp9v6jBn7LYLq1R?=
 =?us-ascii?Q?cCyNGxxM9m0Gtg9d5pXIwCVUD2cZemdfxWE0c0B3ARI+r5IOpxGMqwjgYuLx?=
 =?us-ascii?Q?93/0HSqi0CfRWdV1k3zg7mqaaBCJSGLyaUt+dmrLI+cYSkb1TLaHUR/Gf9Kp?=
 =?us-ascii?Q?DJddDynttmB2dwcNAFQBVUBTZl7Rh82M10rg+/FdmXcR4baQB1fhzelt9mhz?=
 =?us-ascii?Q?9tmMd1vlTNa1wCKkwRK0enzTKyH+s/Hl0eIgxP1v3Nt88PQFxfBWXtMOSoWb?=
 =?us-ascii?Q?/iNO/ZJNgkbG29fj8gbt+1CJXSaSeFhHqfI/D4rAPjhSOsNo7X2uRuU9kRd1?=
 =?us-ascii?Q?rnXeXmDl9C5ZESFARTPM3/6UJyowk8lrkVyyK1gUV5j4qD8dNb5H10jzASg6?=
 =?us-ascii?Q?RKo4HLGHATt8ZPGEXtyJJ5ZpPxqhdfsd7xxmwT7z716QAUkMNOoWZK9yTQUI?=
 =?us-ascii?Q?2yFAHurikZnC7uLyfWIZvjOkyvb//06ZSy4Cnag9mCa/EVA/3Ut+Ej6/KNdk?=
 =?us-ascii?Q?aDlLNpBKKa8WHR8xorh+EzodbSYNL3C4xDcF32MgsXgA6MGcIEsVBD+2Sk8I?=
 =?us-ascii?Q?bd6wGz/9oqSwc4DXPRRjUg9Et0EK2KCtUTUfhC2GUHyM1Q2LwozI+yWenleu?=
 =?us-ascii?Q?UGyNvSoSQ6nOJBYI3Qalyj73qZQ9IHBpFBqeKNbaXAs3dVdzckU0TVS4PLap?=
 =?us-ascii?Q?EtyIAikfaMGxtdYnKLEV1JMrZSekwuBDyQiPrk9aStSXxVDf8+da/Yz+Fd6Z?=
 =?us-ascii?Q?Y8ywIPNfa7kWEwW3uje8rNKBw4irt/LpE+A6C9Z5i22wU5yyyvPa964l2eqL?=
 =?us-ascii?Q?wyuly0ANLYtQPPZhZewlorZ1PvOeLj8Wdz1kVFQ1Ua1/8Vn/8RvW3Kq8AkgP?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3647e40-5935-485d-84f2-08dc8056301d
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:11:24.4530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drTemRiB2l7lwoIR/fIGQ2iMo8lDa7FiIDmS2eJ1DeA0kMjRQr/50CNxUkK5JYIoQhMrRvoFSsKm3hI8rksQYAoljRJlo7UzZTZZxBN9enw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1054

This patch series add driver support for StarFive JH8100 SoC crypto
engine. Patch 1 adds compatible string and update irq descriptions for
JH8100 device. Subsequent patches update current driver implementations
to support both 7110 and 8100 variants.

v4->v5:
- Dropped patch 1-4 from series as they are mainlined.
- Rebased to v6.10-rc.

v3->v4:
- Updated interrupts descriptions for jh8100-crypto compatible. (Rob)
- Added patch 3 to skip unneeded key freeing for RSA module.

v2->v3:
- Use of device data instead of #ifdef CONFIG_ for different device
  variants.
- Updated dt bindings compatible and interrupts descriptions.
- Added patch 4 to support hardware quirks for dw-axi-dmac driver.

v1->v2:
- Resolved build warnings reported by kernel test robot
  https://lore.kernel.org/oe-kbuild-all/202312170614.24rtwf9x-lkp@intel.com/

Jia Jie Ho (3):
  dmaengine: dw-axi-dmac: Support hardware quirks
  crypto: starfive: Add sm3 support for JH8100
  crypto: starfive: Add sm4 support for JH8100

 drivers/crypto/starfive/Kconfig               |   26 +-
 drivers/crypto/starfive/Makefile              |    5 +-
 drivers/crypto/starfive/jh7110-aes.c          |    3 +
 drivers/crypto/starfive/jh7110-cryp.c         |   36 +-
 drivers/crypto/starfive/jh7110-cryp.h         |  106 +-
 drivers/crypto/starfive/jh7110-hash.c         |   45 +-
 drivers/crypto/starfive/jh8100-sm3.c          |  544 ++++++++
 drivers/crypto/starfive/jh8100-sm4.c          | 1123 +++++++++++++++++
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |   32 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |    2 +
 include/linux/dma/dw_axi.h                    |   11 +
 11 files changed, 1907 insertions(+), 26 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh8100-sm3.c
 create mode 100644 drivers/crypto/starfive/jh8100-sm4.c
 create mode 100644 include/linux/dma/dw_axi.h

-- 
2.43.0


