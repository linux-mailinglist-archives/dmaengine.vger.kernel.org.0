Return-Path: <dmaengine+bounces-1259-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47D02871649
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 08:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656851C2204A
	for <lists+dmaengine@lfdr.de>; Tue,  5 Mar 2024 07:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A727D3E8;
	Tue,  5 Mar 2024 07:10:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2126.outbound.protection.partner.outlook.cn [139.219.17.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466445005;
	Tue,  5 Mar 2024 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709622633; cv=fail; b=uNj+KiO2lcTwKzkfhLHg5CzL4j9D7G0fCuMuz2yueec/6P+funzx4Y+rZqfIDhqcBw1ReYcJUGozgNtdu40ddjUd+mpx69kqQ+pUgBrlup4cgEHfvuyGWEJHsjtryRpCSSLbNtcsyCle6nptg2ebiAw99a6nsIzpN/rbYxc+D24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709622633; c=relaxed/simple;
	bh=lCUd9sY4DiRxf5QwG7u31+btY1ga9PJzd8YghrHSDX0=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=i4Vftp7ABIGx7Rs+WYJ+fxa29Oyxm8SsD/4/7QFKZRAK5FvKnjFH4g+B12AIW5KfItM6Yj0HWqbibS07UIW9ADpMLXzF79gL+Uf/bfWJs2cKkrdxhYZNXfpi24FIpeE8GKea7nWWHUPf4csgtka0JCpU61ygtmf4Mg0vH5jQPa0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvIT1v9WybX863TpqX5plfNAlCO0OJ+QcdjGuLunzOyKG7q/W2Noof5PvwurpFbvBeJmsCC8Zzw5/fFImQsIlGpC7UXunZkXMxY3taZG9clWNwoonqxxYFl+L8LDvKrmDgiT5N6rN4IDpwRV2xvk5JhRT47S8BZVxuykjNMjynZLkERsRyTaE8i4VGbiPamarJaINqLSLC3rU8g9qEt0OXcPEoI7+raiIN92SAVCh0nJ6oPUkLDX+Ba4K3SWzhk/6l+xH1CW9pAE+WJkjO/I9pPjTBDooklO49sFX8sU3a2qy+3rAJjdWk24RjM9PBI1m/WU6fVeXRYjzlFJvgyhzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yCpmkM+i2ozDhf4c8Fe7JodACJFOXykq9RVlJpCOavw=;
 b=hYDzHblEtdNKdOF5VuHZot+Q/v57daeYjdYMrbMB90MCQxQUG1b12xunL3280osICyjDzv0u6fOrFS9d96hPuWFLYfvyUi0ukt2s70S6vmwg1tRi2SA3hmHSbPL4Uf3kyd+BdTmkUbhWtjvEAKjdsfp3IniwEtkhpmLaTWNWXaCkyKQ6zE7AM+iUTVZPOwmLxkvAqgl0JuTwl30JeTVeu6fWhXlChwJZe7yUX6UMRVlWfnkUlcgsjMndpYbNtsW+Wv1+59sWRRSITV6NCDJlX037YMts1r+26xdDTBdtus++Ps2at7PQi3HCEzFcMl6WfAZ74P4hTYgVRTFNkCdDqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0462.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.51; Tue, 5 Mar
 2024 07:10:18 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::9ffd:1956:b45a:4a5d]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::9ffd:1956:b45a:4a5d%6])
 with mapi id 15.20.7249.041; Tue, 5 Mar 2024 07:10:18 +0000
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
Subject: [PATCH v4 0/7] crypto: starfive: Add support for JH8100
Date: Tue,  5 Mar 2024 15:09:59 +0800
Message-Id: <20240305071006.2181158-1-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0019.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::22) To SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0670:EE_|SHXPR01MB0462:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f403a54-41f4-4231-68e9-08dc3ce35074
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ryrcbg1ITEZrLmo0d1tmXV9n4ey29Whb9xf37D62//2EEE4us6i58OhkbPlWD3kaECmn8N/wKjZGIG/UYaYXRGF8TgDYMHAxd15MZYzc+8HxEn8znTjm/WslDPO6z0Jadh1MEJBANThXSlH0WSZxvExR90fHjAnjqx2ZTFjOFeK38qKqWW5dsJan3PMK0EDLuf4evyFoSIy/LuDN9C6vzfPfgFLes5khi/GnWhX+AeqKGihxGnJgOrcgY3IWcH6eqJCBSyzwPpxde1Sy0IIWoLPXOoGRgHBIXAWJd0VUOUdlxCn3bedRo9L1jERb8C0zL5RmXfdhPdbaHL9gHZzt0gldXDLEgmpo14iBYyacDUgaIuPWzCGdWr50r2H+TBtYjvFgqiQ+R20SvlK9XSwqfz+/BeNjgn8Pfa64wjp9g9r6j3G4ATgh3X5NoguxxbjNW1Uwe6YCTAUedfHmFWswfSEO+u4jN92rkHxxaPCkbXS3gQ8Eh8goeNIGYlhBOT/ieA/oIGAp29YbyupaDawFGlBOR//2eijz+x7v/3ZEJZkDB1oEZBAuU13tkbZdmgtu3XESEwGHnHkp6svjBLZGFqaO+XYcn1ybOXyI4/iqFx8RBNS+CZmOrCKiELl14T0ihJJpETw6AcjXCnIpN7C1Kg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QCCYxNstuKTxnXd746rcA6fCdiosnwdK+SEvCaPe6S9GyG5UAiFxg6ikQNdQ?=
 =?us-ascii?Q?jYCUWWqcgxMbwQt+hBnYKPQhv7GbYL3q9JTzX0yZBhVD4rbQHhvrakEEgknj?=
 =?us-ascii?Q?rYSyIVDOZKh90BXszqq/BQTb2wUtBorE4VuXCMxwfVT+ytcvQCUWHQuVjElv?=
 =?us-ascii?Q?XZMAlyXXH/pWXM6/QyUJNq24hnTO8UNfdYZ4eL3yvBWQWQPSE76xLuhGc2U2?=
 =?us-ascii?Q?q8n0x44tpDRg6OenDHiRfW2oVuAumqY+VZGdk/8voI2BC676I9tSUiAPfBR6?=
 =?us-ascii?Q?OMNxJaELpl9ZRIB8X+4ZeHL4NL6Lp+lzOPsPgLJIHf3CsGxGdt+a6abXdpz1?=
 =?us-ascii?Q?4YqP9QJNXzmOLlP5sH+NAg+Qe0ybS60BSPoe+3hPj3Wf4rLQQv6b6ER2skHq?=
 =?us-ascii?Q?EYly8DFxdbhlymNH/70q+rzAPxY+AQ/evPgrLGU32k+ldfl4LkANhDB49rLp?=
 =?us-ascii?Q?ne5HCxYhePDjDAawTpnuDaYb4t/rXZA5qJ8zzaxwjCXXo4jQ+vSc2UcjvMEn?=
 =?us-ascii?Q?DsFG4q+ixEB42AW0fCOP9VqJpu++caysdxq+9CCvx8yeTz9Vu3VgCbPUpBQ2?=
 =?us-ascii?Q?+YvKbqD9n4C5S0/1QnCj7LLVMriSTOz9HlD+fOo2Fbdy0IGAGEbu+6fTDesP?=
 =?us-ascii?Q?FjiOdIepfSPqnTtZUIjfLeG6t++Vb8s/alk2f+Sh+Q64ng8WWNg/XgD+81Mx?=
 =?us-ascii?Q?vcoN5520asIu7ibi80vsTE1bILBOwgetdvuWWE15+VJmZnS4r5B1k12VasKa?=
 =?us-ascii?Q?J+ECwnB8/3MFujn6ccuS3rtcjWMbc4rBRibSbnXh1N6p62bdIyVcGNCn5Uqb?=
 =?us-ascii?Q?uS6hazwS35b23VqeGRShU6pFvOgodhM4UZ754OWRJxHp1keN1z/Zo3yft9h8?=
 =?us-ascii?Q?fshYNkjcUva+wrxPTD0jZ0MS+MfFf6LAvMSOutAaB+tpU0xQ3Eple9QyzzfI?=
 =?us-ascii?Q?d1iWvAZqFa8P36zh0TeEYlfdSMVC9ildcNIKqf4O31/r3i2lQhGXPlQUJkCR?=
 =?us-ascii?Q?ne3OSR0MRRmRCoA0yRVVBWQPB8uyUhVgauIxE9NKO6cir+Jwoz3wRVzDlIjc?=
 =?us-ascii?Q?39IO1ruZi5o9WJmDaVuf3zaJpqCBr3rJdiRxcuuCvm4NtkpoRbCayG462shx?=
 =?us-ascii?Q?IUWKche/yQ3jkSTK9mT40GPFqjsnB8LDO73FeFM7H/PxYvMnsJlURfgOv11B?=
 =?us-ascii?Q?G/eW1ZK90NTw8M/c8D8vy1+VCM6SNlfi5JoytVmae3WccHCRzocG6EHoaRXa?=
 =?us-ascii?Q?wppnNrj41sjZMMLWcnCZIW+2bAS35Gmrk5tEgJb0SwEeVlJQTOHiqJFmdcbd?=
 =?us-ascii?Q?mqbH0jbpZj4oSt7bR8slwbyFBtS8PZknaI6Rl076L5IWz1jYsfVApu2jqH11?=
 =?us-ascii?Q?Bdj5c/a54V7pMtTDEF1Vm5BAUwNJQnAKkmSKbT7ssviAdHfJ+ihmN7sryrMl?=
 =?us-ascii?Q?OZ9KuD+oHPHmTeZFGoNKV9hYhUayw++iHSrjjrxoXDFl2irklR7eJZ+vEj6+?=
 =?us-ascii?Q?esd3Zzsc01q65xUTH7y8Ato9ECy/ll3HJcygblSD94aEKuSaJ1/RWBJAh2cy?=
 =?us-ascii?Q?7m313lt48pDSeSo2BMPXRZCXI/WFaJq5ZgSJIXt5sU2tWyqwdS3i8ElXC/YP?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f403a54-41f4-4231-68e9-08dc3ce35074
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 07:10:18.5662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhM/nDK+X0+9MgkrHB9/PYdvQA7JPk7qrrwUmprSCL8dXmHaB2gwb5BO1mDSMdjez7abdvrgYAxy4AQgjN7iuZ5dWQ8DKbfkqUwvnJnZcCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0462

This patch series add driver support for StarFive JH8100 SoC crypto
engine. Patch 1 adds compatible string and update irq descriptions for
JH8100 device. Subsequent patches update current driver implementations
to support both 7110 and 8100 variants.

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

Jia Jie Ho (7):
  dt-bindings: crypto: starfive: Add jh8100 support
  crypto: starfive: Update hash dma usage
  crypto: starfive: Skip unneeded key free
  crypto: starfive: Use dma for aes requests
  dmaengine: dw-axi-dmac: Support hardware quirks
  crypto: starfive: Add sm3 support for JH8100
  crypto: starfive: Add sm4 support for JH8100

 .../crypto/starfive,jh7110-crypto.yaml        |   30 +-
 drivers/crypto/starfive/Kconfig               |   30 +-
 drivers/crypto/starfive/Makefile              |    5 +-
 drivers/crypto/starfive/jh7110-aes.c          |  592 ++++++---
 drivers/crypto/starfive/jh7110-cryp.c         |   77 +-
 drivers/crypto/starfive/jh7110-cryp.h         |  114 +-
 drivers/crypto/starfive/jh7110-hash.c         |  316 +++--
 drivers/crypto/starfive/jh7110-rsa.c          |    3 +
 drivers/crypto/starfive/jh8100-sm3.c          |  544 ++++++++
 drivers/crypto/starfive/jh8100-sm4.c          | 1119 +++++++++++++++++
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    |   32 +-
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |    2 +
 include/linux/dma/dw_axi.h                    |   11 +
 13 files changed, 2437 insertions(+), 438 deletions(-)
 create mode 100644 drivers/crypto/starfive/jh8100-sm3.c
 create mode 100644 drivers/crypto/starfive/jh8100-sm4.c
 create mode 100644 include/linux/dma/dw_axi.h

-- 
2.34.1


