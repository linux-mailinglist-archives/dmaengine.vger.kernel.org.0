Return-Path: <dmaengine+bounces-7768-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78160CC8674
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5506730140C2
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E44934FF4F;
	Wed, 17 Dec 2025 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BnhLs34r"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D25834DCDD;
	Wed, 17 Dec 2025 15:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984603; cv=fail; b=pVDtT5IKJnwBGkbm0Dd2BiYWdg3EH+GAl44qTniHgpXY7O47TxpENn9n1KPyDwV/lnCVypW82eue8JcvTTneEy2Xo0j0VpvDs5+JLRc9C8hzvwnlH+uqCCSWRICtAHRJExZy60j8IR9YsHuHAyaC07sIINGu2AhfQ1fO7RnIHo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984603; c=relaxed/simple;
	bh=ygpXfay9LIy31jIC4H8offCxBPpJRyPo1Rg9zTYMN2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UbUDnGOK2LDio+PWnomzSOrAg/Xd3xz2NMvSNoi5o7WUuapzkr/q4eIKeQ7FqmNYWEZqnaLZZ8qg6rwNfhKxEtFMQzImQO5Jq1aGMYylTsd6FnMPjuPEn69pOvPp8G86xM9A5TzTuAiKAOZiificb3/mw8z7oyfAAGE0tfDSvLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BnhLs34r; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGvyTZIgL/GlLq7oNt2ox0Cmdh9Zut8rrJVwpAIz7Aww4G6Q9z+qkYIdUvvLZBTxdt2t0NY74i2MWEudtmb9YYeyHLcHB9rH/snkGT3/vou6ry23hSlbsFpoBbzopmL3pu6Kw8aAc3gtexQ6onVtFP13BmhOpHX8ItZbtDUDrtTUnFZBLntn0H+vtCtvSev59BcnZXdAC9l/l8DHlga5jvukmaTJd9WgTT2GRvIJAcuPqZ67HDfkQVgcbDaADvhtCo2YLLlS54AYZ7XGVU8semENzXf9mUKvDsARKwYbjdrz3JRVN2mpOsOcucOv3DmF1Md/3mYklBSbfctfbrl5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IQBj+DlAfPQPSnkm2VfGWm6XCIbcSk2iHd9aLxOq/E=;
 b=LQN7QE1B65qrHSBu6H7ebgiKv4nCh94LOkQqDWHruiDINe3JR2BjCd23VZKezC5jCzmVRUVDFbay8SO8xHNawki6/MFc8c1UGiAC8mOfIrtr9mRae8ScnL5uqIfs/xOJpYohWjpTREb4ub64sQtsQOmA860QTh09b9cIWicChkjBPVr132pZvfkD1zeaUXUJ/4OpoOK85EX/A1shyY94J5+277MUMvZkKdVZihU/17CDysSD9tP13eKVpKVhQqssTAB1GEG5Medn4odTQ4LfR2ZVAhBL6wUzgwjEY62BklnfW101W+z4rNYGMUohReUTl/sScakPYdQWMl+N1A8Y0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IQBj+DlAfPQPSnkm2VfGWm6XCIbcSk2iHd9aLxOq/E=;
 b=BnhLs34r2v7Q457r5rcIfXUorXbeX7/wdeYoFYry9W1I4bXhns4icv8iIS4dqBGe7hLCPOWHAFHJwVW1FR4EOhH8ol5GGYKsiIE/h3gQdsgFwfoaKau112t8j5dXClQ/h97p1IUr0zomc8uz9DavcusdSz2CW7CKXA033/f5Ke4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:26 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:25 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 14/35] NTB: epf: Reserve a subset of MSI vectors for non-NTB users
Date: Thu, 18 Dec 2025 00:15:48 +0900
Message-ID: <20251217151609.3162665-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0113.jpnprd01.prod.outlook.com
 (2603:1096:405:4::29) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 19cf958b-15e1-41d2-2aa8-08de3d7f3ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8GPmYHkreRpmA/VQRwr8Fxz/GgxS9VogGdqopfEEj31zs2SF+y8ZJtx0684t?=
 =?us-ascii?Q?cPjmjanoWXPUx7eE7Npx2MbBty5kjKWLTPKt0BPAS1/WTjXp/ad0tnlrl4C1?=
 =?us-ascii?Q?YG9E9TM98VQvHINQIXg0661sznO7d4J33JO1zWVIoxY39Psa38NC46I6i2uc?=
 =?us-ascii?Q?MsDh/E9pJAHfQjsiNWjyslOFPxPkEf0mMkbaamp4/l1uIezlj3CqmzzB8Uyt?=
 =?us-ascii?Q?TGUiUk6mUjEjjSrvlG6GCN91vmAo4aIip+IQb0O1zF+YEDPwO6BvAibhPxGx?=
 =?us-ascii?Q?Ei/JoX74KiIOSs7Fl57rB7sSMQlxarrIRWuszK8MCG8Os4iD0vsESV2X3dhu?=
 =?us-ascii?Q?DonYsh02Vj3dJwnVWTjU/1Oiu3Wz0JGXPApNC09YK+LKjUvMj1nqnxjFTtvG?=
 =?us-ascii?Q?EYwjXa+MPIvh53m+1ZvhiGdSpi5I2d2ioqjz+IiODvkVSYglLuDF/SOPQxMO?=
 =?us-ascii?Q?Kd4EJhtF5Eqj31AnF/KhDfvJx1xfE61VEYfE4HSUEaqjftYXU9g2rvI3n8P6?=
 =?us-ascii?Q?qCujtW6/xzEzUugH5typdZvjPqimmjE/EdAxE4ok19xoJNnajFSxwJ/DkFL1?=
 =?us-ascii?Q?Rinx+OMN8jWY9iNKYfOeVj/ezmYrMnrUbD82mjQl6xF6mCl1QOPywJDOsEYH?=
 =?us-ascii?Q?lRQlt2PpjgGlkGB6gjQrXPmdwP/tOovNW8Stz40rjBGMj+G++bxyN11Uce1w?=
 =?us-ascii?Q?oEmiXgzBuSR46Xr05RKIJ/Ud25ZCo0ILA6rUQPkoDA568+lbzZMWO0f8xM/D?=
 =?us-ascii?Q?X0v+R6ddTewf6ebSn8Dy/JsICr0wMCZiv9Jq41hnjii/Oz+Xk/o/xroYF9e8?=
 =?us-ascii?Q?pTqxShQIQkmE027zX9LqAdp4gsPg1aSqUcI502Dgx9oKhHs5Z/RkWjndhaWw?=
 =?us-ascii?Q?Uy9FnAeXsjSWVZzWQZRczF4EpVLEu1Md6Ht6COI3lOhDCng2GOSUSB41Bat+?=
 =?us-ascii?Q?gKH1xAUekDwn+Rgx5Y5UAHauW0ErFvz1SvEY4oA18S4I9vwlMHQOuWUnvlvU?=
 =?us-ascii?Q?0FbQ7+i5t8N0S6MCFg+ovZ1v8kUC1wIXbK2eeluQmDRAlrEB2l0AzWWMUGBG?=
 =?us-ascii?Q?8zvOl+XwNtuSOhiOWI6uqRiE5m47GpMX7YwcoETwYLe2G2+U1Ql0aqWnNmXZ?=
 =?us-ascii?Q?l5LzNXPde/lj9BDr1w9GuBD8w2jIM6w3gg9SLg8orT1RUHMUG5ImjAMDY3PF?=
 =?us-ascii?Q?v+rQ3sQM+OZkn7PBD3F/3WOyYVtN0rsAZMCF8pkXjsq+lVgRblXu9R3/WLrW?=
 =?us-ascii?Q?ZEtypIR1ThBZAQj5D6BOJC2GgACVnAfJ9JHxfumkupv5gilcMZi4qeBgy64J?=
 =?us-ascii?Q?1KadAFgxwRORIRfc19ZV1VBlLeXHkb7ToOVtdlKZHev+d+WA5PMmjOsTDLgz?=
 =?us-ascii?Q?9+suqlHO8MIoHg8j8ARotrRc+FaCebGbDJAkzKOZhMrjaRnKx1H9GBEgbtne?=
 =?us-ascii?Q?cHA4pO9CMHL1m+Ei8yI7ltB4F8w99iAy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ykTbSwdZ6hfbVC09eFyJsPQORkPjsNfjeiMEdDaytNoPPCq6+3v6vSI9k8Pp?=
 =?us-ascii?Q?z1zw26dUOlT2AlvmjkpfpvcDxjRyQ2q/HrKGYg5naiwCTtNOubcMXn6HlcKY?=
 =?us-ascii?Q?N5KKOX+Poq1DEJEIRwcSPNeZhufFr6bZp9eyfLW9WX+SJulVF50s6scakq/0?=
 =?us-ascii?Q?F7tRS/bp8hm4OG4A24tV8ACpPmF+TB/N0iHtI7I63+4RDJi2krS85KBu9MZo?=
 =?us-ascii?Q?KtdKbuNL6nxySxJjqDkkh3OIpNx555WlFmEBeFjQNRirAgJYRtho8vfiqUZS?=
 =?us-ascii?Q?RPgwhQbXn3/IBSRLW/ng/VsbbUe6g1b3+mWkcVdCejbao9GEmfNOS6E5wPR/?=
 =?us-ascii?Q?mK54dlIDypn/WvccLnIqIff5f1AOuCqQFSmDM58qLDYc1f+NujDRaHkMv1bk?=
 =?us-ascii?Q?BQHfzbWCNkKOrY0q2PXZfH2iWNZTiV8oqSQBFxzP8vlqYFvur7dNDu6ri4o8?=
 =?us-ascii?Q?UBQA57hlEVUMBfy4G1givdxhl9ECedWY1umJkkrH7vkfJvEUjpkcaZcAxyoa?=
 =?us-ascii?Q?1WKDVEkpT9PLwOWdLvzalwJWL7BHj/umNfKcIp+TOaOZ5k4U5nGb+4tKlSih?=
 =?us-ascii?Q?I6LBrIGMT/DIhWeJeuevA3xUo2PZ0F8Zj9aZK6Yhfs4zM4k5/k6XOa0dZnNW?=
 =?us-ascii?Q?nRxSMohO+6VBfLGlntfEfklZ9ZJz/ORaKWqAaU/NuiUWuxqPCUdQvNVVcvdU?=
 =?us-ascii?Q?7h7Jx9auYSVSjxkJd4OqmdOSFwKlQcyRl9EWz4kyagcc7dAMwt7En0+rOcdm?=
 =?us-ascii?Q?HboQ6KG9Y3UqYcf3ojLYd1ZM23+IcUXIw522HY2zCUkkRvJ07XuwcDa33S3C?=
 =?us-ascii?Q?90Vm+1Wdt/tH+PlxnNksQdc6f+vt6ojrUkwVRHhtDUks0p3o+ZRPgyz8AkS4?=
 =?us-ascii?Q?sQKjgDofOZY390oO2elpX/c1ZSzGEkTFw1VwvG6gwcrqAgxn1heKx89+O5iw?=
 =?us-ascii?Q?6u5BtzVhPxV0BTh9ozRcmG0xnVTQWkjTrOb8mTUwNwIhSnTnoxB0Qp+ZDdAF?=
 =?us-ascii?Q?ECZ5HavU0s3PLAIymwhlgXSCeuREDq8NuxPn1XSS+Ms86S4hqSdXyEqp0Pkm?=
 =?us-ascii?Q?kCjYs2oNLh5f6oiQm9ynFoQWjhknzR+VL24Itmk/GT2aUyije8R7dTeBab6c?=
 =?us-ascii?Q?B3dKKmzLykND5SkU9v6zb0WNhmsK9sNfUsfiGpb0sxW8Z1kcDW5//tJ5hmyn?=
 =?us-ascii?Q?G+d/1mY5M076cCOH/SLDDxFWURVPWel9anGoogUjo7S49FVWGnVrnrj1+cAv?=
 =?us-ascii?Q?60mIQI/i1/VQhoH137QUZqxQG0td/jKaYiK1a7U5tTj5TewMqGUy2dL5N5eN?=
 =?us-ascii?Q?GLvbE/of0Hm0nr2FYwpmomSvxIQfJr/epM+UEsnXhNQoggCgmMVOJsyRBLTs?=
 =?us-ascii?Q?tz3+o367HwpF44mQ4Dcif8QmZAt8BnG3MYfvSdAG4pFmUFAbYLvppmIMvsu0?=
 =?us-ascii?Q?0mRu41KdwJyenp8ncl7Ti+wg6Ad4dINRuBqvkFP58IgS8tu8C8iX+lgDzqMJ?=
 =?us-ascii?Q?acHJdPjQkbtcrDWSCWRMz9h6G0zjK7WOBVmY/kqmBgTUeS6ixxxAcEryWY4B?=
 =?us-ascii?Q?bOhk6y3wVFWvqlqjL8kqEnjz0FdnvoBsrmgQurq7do8qY/EgoaJU/vq0asZZ?=
 =?us-ascii?Q?RDXGxGpW8yG6UhXI4OJnmp4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 19cf958b-15e1-41d2-2aa8-08de3d7f3ed8
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:25.8360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wQEUVIhL15dE024fG4SdAG4/rzuwdiBP4lem2LQQm9uQvRmUETKFdc+PfNuD1mf16NWZw6jT4MnRg/eEoyQyYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

The ntb_hw_epf driver currently uses all MSI/MSI-X vectors allocated for
the endpoint as doorbell interrupts. On SoCs that also run other
functions on the same PCIe controller (e.g. DesignWare eDMA), we need to
reserve some vectors for those other consumers.

Introduce NTB_EPF_IRQ_RESERVE and track the total number of allocated
vectors in ntb_epf_dev's 'num_irqs' field. Use only (num_irqs -
NTB_EPF_IRQ_RESERVE) vectors for NTB doorbells and free all num_irqs
vectors in the teardown path, so that the remaining vectors can be used
by other endpoint functions such as the integrated DesignWare eDMA.

This makes it possible to share the PCIe controller MSI space between
NTB and other on-chip IP blocks.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 34 +++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 89a536562abf..4ecc6b2177b4 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -49,6 +49,7 @@
 
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
+#define NTB_EPF_IRQ_RESERVE	8
 
 #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
 
@@ -87,6 +88,8 @@ struct ntb_epf_dev {
 	unsigned int spad_count;
 	unsigned int db_count;
 
+	unsigned int num_irqs;
+
 	void __iomem *ctrl_reg;
 	void __iomem *db_reg;
 	void __iomem *peer_spad_reg;
@@ -341,7 +344,7 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 	u32 argument = MSIX_ENABLE;
 	int irq;
 	int ret;
-	int i;
+	int i = 0;
 
 	irq = pci_alloc_irq_vectors(pdev, msi_min, msi_max, PCI_IRQ_MSIX);
 	if (irq < 0) {
@@ -355,33 +358,39 @@ static int ntb_epf_init_isr(struct ntb_epf_dev *ndev, int msi_min, int msi_max)
 		argument &= ~MSIX_ENABLE;
 	}
 
+	ndev->num_irqs = irq;
+	irq -= NTB_EPF_IRQ_RESERVE;
+	if (irq <= 0) {
+		dev_err(dev, "Not enough irqs allocated\n");
+		ret = -ENOSPC;
+		goto err_out;
+	}
+
 	for (i = 0; i < irq; i++) {
 		ret = request_irq(pci_irq_vector(pdev, i), ntb_epf_vec_isr,
 				  0, "ntb_epf", ndev);
 		if (ret) {
 			dev_err(dev, "Failed to request irq\n");
-			goto err_request_irq;
+			goto err_out;
 		}
 	}
 
-	ndev->db_count = irq - 1;
+	ndev->db_count = irq;
 
 	ret = ntb_epf_send_command(ndev, CMD_CONFIGURE_DOORBELL,
 				   argument | irq);
 	if (ret) {
 		dev_err(dev, "Failed to configure doorbell\n");
-		goto err_configure_db;
+		goto err_out;
 	}
 
 	return 0;
 
-err_configure_db:
-	for (i = 0; i < ndev->db_count + 1; i++)
+err_out:
+	while (i-- > 0)
 		free_irq(pci_irq_vector(pdev, i), ndev);
 
-err_request_irq:
 	pci_free_irq_vectors(pdev);
-
 	return ret;
 }
 
@@ -489,7 +498,7 @@ static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 	u32 db_offset;
 	u32 db_data;
 
-	if (interrupt_num > ndev->db_count) {
+	if (interrupt_num >= ndev->db_count) {
 		dev_err(dev, "DB interrupt %d greater than Max Supported %d\n",
 			interrupt_num, ndev->db_count);
 		return -EINVAL;
@@ -499,6 +508,7 @@ static int ntb_epf_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 
 	db_data = readl(ndev->ctrl_reg + NTB_EPF_DB_DATA(interrupt_num));
 	db_offset = readl(ndev->ctrl_reg + NTB_EPF_DB_OFFSET(interrupt_num));
+
 	writel(db_data, ndev->db_reg + (db_entry_size * interrupt_num) +
 	       db_offset);
 
@@ -581,8 +591,8 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	int ret;
 
 	/* One Link interrupt and rest doorbell interrupt */
-	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + 1,
-			       NTB_EPF_MAX_DB_COUNT + 1);
+	ret = ntb_epf_init_isr(ndev, NTB_EPF_MIN_DB_COUNT + NTB_EPF_IRQ_RESERVE,
+			       NTB_EPF_MAX_DB_COUNT + NTB_EPF_IRQ_RESERVE);
 	if (ret) {
 		dev_err(dev, "Failed to init ISR\n");
 		return ret;
@@ -689,7 +699,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 
 	ntb_epf_send_command(ndev, CMD_TEARDOWN_DOORBELL, ndev->db_count + 1);
 
-	for (i = 0; i < ndev->db_count + 1; i++)
+	for (i = 0; i < ndev->num_irqs; i++)
 		free_irq(pci_irq_vector(pdev, i), ndev);
 	pci_free_irq_vectors(pdev);
 }
-- 
2.51.0


