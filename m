Return-Path: <dmaengine+bounces-1543-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8818B88D5D3
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 06:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 896AD299A9B
	for <lists+dmaengine@lfdr.de>; Wed, 27 Mar 2024 05:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E63E572;
	Wed, 27 Mar 2024 05:25:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2094.outbound.protection.partner.outlook.cn [139.219.17.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91E6610C;
	Wed, 27 Mar 2024 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711517114; cv=fail; b=DFqebHTFSr4jHsII37NW8OIENfEG7gjamk7Sv3pEtFSDG9ojtNKTwuqbqKqH2XwSpb4o9FLZPa57DSN9ZSD1k3chYZUWsshZDC4EYK4FjQTuctn/8ME9KgOyJ3UbPrGVkGEbjVqc99kk4qgkENUf4PwdmdOuzBUl0NsfXeQvBxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711517114; c=relaxed/simple;
	bh=rrLnxM/gpFcY9H0ewugC0wbFDTsBX5O00JU6pb/+qYE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=l8neGdtXbBnau6GSKDMPxJjP3v0lFMr0qTKS66R19km3p10Zv5ZDlD3BA28C95+VOHgLpxgcsQZS0/fSiHqJZ5Nm6q0+xEe9TdYk9W+MgBX80NB1tSzQQwJJmTvXK8IavWVeJraGjncE5t4pQ6u1/wkE3P1W2lm/RoO4xLGKRds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKH7gc6cY+Gf/l56eVxACCXY4Dg1DVmrxCO6O7TM4vPNqQtHuU7lYw1vM89rPIR+SYUFioOpkiJUl+EJU4n+EGQjjsQLAmAysacotjhByODzqSRNFMT+TpV/yWgvBhibDxy2HSArzpjdbL3z0r79eg2me0Zh+yXFGWxEZi7kVis1CdCOQL+SCcYEbIAWKOpF5AGefgpEeFD8c4Py11DI4bBuSjM0MwtWTp195PPu9cJgScSYFtg3BdbjPf0PPVdna1yEAMf2w/ozNz8wriBa+IK5bvbj/NcJZbWfSVijl17ZQjYNU6DlVfdQS0Ddj1yA59iAldLrc4jSpCYrhcHYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiLOffbc2JK/tnsUVTf5pujCs4c+oNK/8mF0XjODiwA=;
 b=L8n4IpUZOpFSW/1Qmq7NRb9yTEh6hqRA3CuhM+7ZPIWPCrz0ca9qzsgMPBsIxsfoKTSKMZS5p4THjzP/BebFc5n4tT7uRBLJo+HJi9x6Gdwj6itTiCZKRwbuB0CgjLX6aGuDBkDsIfplok5OFlpSM1VfwyMh2XWVaRYUPy186KKPhXkCX+P5yIfG8om50GqpG03bSCduq0MZrecOHN42HEX3QtXcV3c20IRLATZNbq1mZqszk9UHnBGoHDQt5mprTdXvymyz0IKcz2O6kd38MDAYvifwxdtem+9BK4VN7tBbG30jW0Ri5MJloZahNryrxboDv2nT/+HpCLC2wNKheg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20) by BJSPR01MB0547.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 02:51:39 +0000
Received: from BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 ([fe80::d0cf:5e2e:fd40:4aef]) by
 BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn ([fe80::d0cf:5e2e:fd40:4aef%4])
 with mapi id 15.20.7409.031; Wed, 27 Mar 2024 02:51:39 +0000
From: Tan Chun Hau <chunhau.tan@starfivetech.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	Jee Heng Sia <jeeheng.sia@starfivetech.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add JH8100 support for snps,dw-axi-dmac
Date: Tue, 26 Mar 2024 19:51:24 -0700
Message-Id: <20240327025126.229475-1-chunhau.tan@starfivetech.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0025.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::7) To BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:e::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJSPR01MB0595:EE_|BJSPR01MB0547:EE_
X-MS-Office365-Filtering-Correlation-Id: 584904d4-5531-4bb6-0481-08dc4e08d38f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C4togV+OzCAygjp8LH+ocAHwM8VWoK56dyHW3f4x4MEAskAqGMXfpJV5YkQ20+ATpMdwXUiKXkIkGXnHhWjtLlXW9tonGiRc4MGIWqW9tVkVkUnRTumrZNzM5EfZvr8XKOQmCslbcFnHpbUAIyAf+Y97c1iA4LFc23o53mgKcV8A2kbh0oEebT8YIQPMI37D9O6rzAzU59pENXEb5A0VQ9hl0UgFjgMyZERMvK+fNDE1/1BzHseWFF/X0+4K8Cr8N6fDB+bWEGoTc+F2LPdR/gl16KU191Jlvq6tvobXpVl77cUKHJCRUhrGpK3MThmnSuJAM5A4oiGJI109BGdgV+K5aJMI99B04mB+1ggZ92XKOAwEU9lxSsHA0JHwfN85pYeAZ2Gv4c+/A/N7sn6aioBFt8Tjazx5fKn1PIYHXWepzfeB2UyfxI5M4URsxOKlBkBuGRZRHfONCwFi8YAvy7Bqc8Z4tRqOq2b8OwAz+teohsN8rhgjHL8eutMO9icEO/bmOEQK7c05uYlmEy+FMGreFK6hmj036Z45QW4oXYP2RW9K7ZU8Ax/yFpRveFWDlg3MPRtlgW68TlIcXYwCzWmNtDeB9zO1ePMSpVxJ2mM1aL89jdqb428+GxnlHc3R
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cTyepiLVhGVrzsXUEomRZatQho9qKpoaNXcrdDVrlU5cvfbk6ko3sTK1Q2Ao?=
 =?us-ascii?Q?wFW5xno107YQH1iiZ/SLdJkUFiStoA52lOdGsYXymLobr0so+kcMK9jWpd1n?=
 =?us-ascii?Q?1ixKz+gIpFv27cj1/C2JVRPdzoiTl/Zsk2SbQdZpmRXlOlfwtFdNwEaEBIJs?=
 =?us-ascii?Q?QnMEDZDf84fR7qpUWbv1GobYkgEVGxsLe15xTvj3rr33K1IErv2edJ50gVFK?=
 =?us-ascii?Q?WPVApk2PrZ1fcnxQbu3es19CFR/xJStyE45EYTUZ2LEJVhJ9SWLs3nwi9ZoL?=
 =?us-ascii?Q?g6e+aHaNtTgbOziV2XHzzo5s+FC1yjX6ycL61fTiyYc66WCxtY3n1yL5N6vI?=
 =?us-ascii?Q?zRctdTtI7QZHxFdC3NkWcygrs0PmGSLeP8srLylsdCNgkxEn9nzt9SXxe93f?=
 =?us-ascii?Q?rhmBrwupQqOqIwZhAJCGJOW0eQL5zy7I1qRy8L0ameP65B+mKoWdIXJoVRh4?=
 =?us-ascii?Q?/pL/iRGAQwFDzzPxaL+LUXL6yOM9yAxxNhXXo/3kbRXNTwfjGdGjZH15j1w0?=
 =?us-ascii?Q?d6H1w3PBd2iHzBtT01TOdpNYnpy+FM7co0/j9hUgN1nZGcrVKleZ0wZdhUvI?=
 =?us-ascii?Q?9XxuDPBm3w4+NHko9ItJXYKpYEMi5SGXRqft7QxIQUiBmL5cCV6D3tdHChIG?=
 =?us-ascii?Q?wothD5TW1QSMokYAbMm/bsI+y5bMsMOQv8EpApD+JNtRv/0ckQ5zEXaU7THl?=
 =?us-ascii?Q?kb7xdGxL5NvPyUFLY71dA+NLMhzL5BrSKoobrs+k/GE4RRrG3RIFt6ifFhk5?=
 =?us-ascii?Q?T2jNhcWgbDuD5goncMfmSFfoXccdcQVziHFdGfC8uvDWX+1j5nTOiH2KkW4u?=
 =?us-ascii?Q?WP/tI47wXzMcJksGP32iN0ZdBdQ7s0aHrktGxnpk4ITD/DZsCDh4BcudjHdG?=
 =?us-ascii?Q?Kk0jjJVz4kpPmU6B9DtzthRJsd3D1ZLFH5VkX1Ws6nwtdj/zICG7DaWOLqLF?=
 =?us-ascii?Q?2oTf7hlMzjkrKCi0ZZOfb+IeYNYLAbYfEJATKHwQO7+PTtq8u68UVLqdkk06?=
 =?us-ascii?Q?tZL+2yCbjDu8VCMD/xkFbNa1MlE0hN83VJFc0bf49CKh8PB66Q2jd2dvSZd6?=
 =?us-ascii?Q?CK1phcjHww57NfMmCEouVPK7NLl3piIbCXOP7WvcqimWUVcXmS4ONJL2lKbN?=
 =?us-ascii?Q?OuRKs5kHMBBzNuDHdOxSOuGn6KKKovjpZ6VmvOfnwZh/6OXDC6og+0m4EEtI?=
 =?us-ascii?Q?ItvgLoW/CynttUryDmIOKEfUZA4Ru4WtlWboIL0c9hTRlp02LE5/1KXUOAq1?=
 =?us-ascii?Q?uYEpimUoooQ7djFDpfBA+0qLzLxMcnE3of7mcV2Hn1m4ZA02ImrV6Gk4cGeN?=
 =?us-ascii?Q?FjRXiBEPNSB9gMad0xZlzNgAMVk8jkqnwLWIKBIfH4+XzDASYsh5OAa2U2TW?=
 =?us-ascii?Q?AYZLaVuFSLG6fqbnMOyDpis2JuMAzXx5Y2U4EiFnf9/QaWONCBIM+wJY178u?=
 =?us-ascii?Q?8H/OREmO00lyXTiuT4kbPBaKPJBJd1tnUNV5zBNRMiYxCe8K5nU8GuzYkvGH?=
 =?us-ascii?Q?zJa+UsU0fgpH60U6xorMdj7lXlOgW3FbACcQeZ4kA5kybf0mPTtR8QxQq3IF?=
 =?us-ascii?Q?4iPtur0j+Ndop/fs1jYCI6ktCh4+jb0297Z8kkWP2X4Dwbqwp1KmCPXWurZr?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584904d4-5531-4bb6-0481-08dc4e08d38f
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0595.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 02:51:39.8284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EdlZhnRn83gLZvW59hDn/xaFRiOUkmIJLVBm1/LLUoPGzXdbu51cm0QH868NPDvP7X1Wfw1GlNqkqX+xXw0wWnb6j4CoJJBR0N115AXlFUs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0547

Add StarFive JH8100 DMA support.

Changes in v2:
- Amended commit message according to feedback.

Tan Chun Hau (2):
  dt-bindings: dma: snps,dw-axi-dmac: Add JH8100 support
  dmaengine: dw-axi-dmac: Add support for StarFive JH8100 DMA

 Documentation/devicetree/bindings/dma/snps,dw-axi-dmac.yaml | 1 +
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c              | 3 +++
 2 files changed, 4 insertions(+)

-- 
2.25.1


