Return-Path: <dmaengine+bounces-6808-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 852A4BD16B8
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 07:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18AC71895985
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 05:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C5D2C15B4;
	Mon, 13 Oct 2025 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="V1b+ulh0"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B9222D9F7;
	Mon, 13 Oct 2025 05:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760332680; cv=fail; b=iVXe9zDe+1uiJ4pBSHxQDOfyHJW9Ru49e9KEwNgx6sO2QL0bx4oIT4eHp1wUuWP0y90d3e1zUSNWavZTbJ6TlLezm7lIlGG+X+jUHNlt3aFgT1Wviu/HzlTtxpR9WWMCnGOt3G+YajjQXkk6Ht56aLHuCdKQfzFKBAJWqdmQxu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760332680; c=relaxed/simple;
	bh=5+BnUMp5H074X1EJ09YVzHf5my71pytuBRJ3SIadQxI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=erGtLMERsg8JJopkzHvCGCzN2SCX3yyBId5LDbFcj7WrqJx5L21NCgJwshgAM/3tPmc3VCwn243/NgpIprQVnhc0RO71Xm2ea3zmTKjAlMaOliAkFSfnT6yvzttUKFf3TERr3i2o9Qf50EWTF2baB0oLji0W7/QkQciUI9VEATA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=V1b+ulh0; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=veazT8efowzzWfUZkyqZ7YmENkdIyxVdCwDDm3diQKtYXG/pbehroRGjbPO1a7POxwKyLx0buBOdb+tAQ49H2ee/YZmGPdb6lb9R4Wem4rev3A9MIRl5My7m13ITnuoarjgmspvTn50BDaDTGsHwHw0Gcxm+cmg5N0Dc8Vzi/pYZl2MBrILRNYbL3L5KjjfzPTQjIe7wCnL5Ga4AP0KfHhEZX0/IpnvbIzMdNFSLcVNtqKSXF4N7chEWcaNSfjMVLxis5GT70qr3wSXLm2Gj9dwNpWk8CqDjYAgnYeQwQ7Ic4jSXxVHggdguvDlzFwhlC5TYWNdmPoKTagdz3AhkFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9GZCbDvjRc1g9UavFMT784pfvckFYXEjtzZyoO7mBLU=;
 b=JGxuNrE1WB35ch9GqhhU1zaKjVqlt81NPMvaBBBi/0hdRSyAaZhVe7Kwv0HnQT7bV/qqi5j8vSiTxvas9sGjOCGNCGG7s9dq2uI4X1sKG1uLPmx4eFQc+ck5AmB+J3Ari1xW3OOrKbf19Om777gq4LgCeBwrJtRbN52CRbkvqOm1jx8DRPQsHKGpPZaYsJWiVXSBSnBIFzIHI9t92FOQN9ZkN6B3ZchawxxwP+0HUHZAeeMqS0mpHHxIWku/He1u6hJP/GQwNqauIZfPxXmOjzdr/YL3FgACLtdaHZ/F/Iud+FY2scv5cn/VYIIiTBfTnLrg1BzTRDSYFkIYK19E3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9GZCbDvjRc1g9UavFMT784pfvckFYXEjtzZyoO7mBLU=;
 b=V1b+ulh0ZaVe+9QC/OaJdVhjXCcx2VkR/dPlrtXUpHRLu+B20+vO1Pekfr2OiRdtVfGxHfbPZhH7psIC4lojoKdsmej5BX5lvZZ1smu8xfe1AgaBGbb+LYZLD6jOGwwd/RHH7i+HXK4iKdLVWuXUw3zgJEY6lqfeI2qR3mBKwohWBIhmLOlfnvf99NpyJu7tQcHrqiZuoVPtYkPXbMW8gEB41UmXB6jm2F+N4MSG2PZFmS0TsOV5UR46FLg7peBx7/FCpt/+i3zVbpInvBu7Wf782ADv3AZAvdLTQRsnteRsa+DEZF9D29MHctqR1726Dte2AD9FJVlrCtvNbTrGxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SJ2PR03MB7450.namprd03.prod.outlook.com (2603:10b6:a03:561::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 05:17:53 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 05:17:53 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux-mtd@lists.infradead.org (open list:CADENCE NAND DRIVER),
	Dinh Nguyen <dinguyen@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Subject: [PATCH v2 1/3] dt-bindings: mtd: cdns,hp-nfc: Add iommu property
Date: Mon, 13 Oct 2025 13:17:36 +0800
Message-Id: <60270e2fc2bfb67c0ff4c204e0e8f3395add2146.1760331941.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1760331941.git.khairul.anuar.romli@altera.com>
References: <cover.1760331941.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::38) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SJ2PR03MB7450:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f63ba0-7d1e-47b3-c48f-08de0a17dc0e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?krGX4clde2LymijLxWESsr7bcmDTpB+EFhFZx4SvjLk0QPQGhkMSTM+s8pU3?=
 =?us-ascii?Q?do9np7PJcYcVckx80VJFNqs9DKzcEECiuCjrbUVeHBMbdaUaUZAMcAE3C66f?=
 =?us-ascii?Q?cpTz97JS/DuLqYFqLuCk7gVcsfzeE1Anz7fLPcWb79cYuFr9AEZs7K/ew8ST?=
 =?us-ascii?Q?cBh+fie/A6VVshj0hnnGZLrRXpbuh2mpHtVVOHe23yofx8LeKk6ZQRHuaTEM?=
 =?us-ascii?Q?Kr32e1kROFMJ6MJs5y4fDKxzMWAXyJ+x9SkeaqIgH4Afs7OPJw1djj3qXRuc?=
 =?us-ascii?Q?5/qCDpXBGc3SUyq12PJ7zIA72nJLWqjZDmMCle58abCRcfh7VReHGHdbGSFn?=
 =?us-ascii?Q?VnaoAkgnsm/uDzJu/Qb2dsLMshDKxBVy+g468qPt+TeRfR865c2FUwUHVZgZ?=
 =?us-ascii?Q?h36G7bqgTqA9w8ErSkdSh2Ao3YZNsxwmUK0EC9FAyKxR/zFyo3A6KDF5YORI?=
 =?us-ascii?Q?l76rORZrwH4Ci/yIciOl2ssxxDP92Ydd+gQzkyKteqsbgpxIGo4Wh7J2JjkM?=
 =?us-ascii?Q?F/WMPZUyCtHGM3zd6kkFxhScK0CO2mfJJF7cXrpzInt/nBycVIvZexWmGZAv?=
 =?us-ascii?Q?MsJjL3MdMOc0KeHnphw/Sbls/V823YOZgmyu4r3+k44u/vkLIkJIgmSgx7Yu?=
 =?us-ascii?Q?tz+uC8s4JodKcrBy6EDyPw4geLkI1G1K1dWx/j0peA3Qk6Gtw0sObtzFv5WI?=
 =?us-ascii?Q?xnIccDdqHzmdrfQwR2L37q5VP7iNixtWd0lU+x8x8LSgiNnksOyYvuEEWVW4?=
 =?us-ascii?Q?0z1TVjjsDbNwa4pgD6HLd0KwU5SjLk9ZUTFDuG/T671YjKSapB65ewsgOqxa?=
 =?us-ascii?Q?ih3SIviF8pOv1ghv+PuvMVyX3mGiYos58MaXhUfVqUBb2FtI+9kZCzc5xG5n?=
 =?us-ascii?Q?nMVz/hGXSa0zXXRAd650n31NNc4+fxvkRTQ9LbGOUsWT9TqpvtvUBW+Q+j/7?=
 =?us-ascii?Q?8McRtcQs8Vzqfd6XV/KumK86hF+OhwZeXxQLt+iBNYukH+fUR6xFDLgb6ku6?=
 =?us-ascii?Q?8ffzI4857/3Y+PpIc8K6E72RnLDg3oOJEowh0nZQfKk3BIxCe4Exh8ws7Qiq?=
 =?us-ascii?Q?sxG7Nmx28RIZT9klIlj1Fgrqq4rm/3uN38vdtn3bXJcoUq2DXUspgtBeSzJJ?=
 =?us-ascii?Q?Kf1yXla3Pypdcy3+MrdTfDiQAYvcsFoXRgyxGzfN8sJfPOXS1yX4YBWkIrC3?=
 =?us-ascii?Q?x83dBQnfptY3kQmkPo/CCnHL8spZo97Ayw/GQknWr08g9AROCps7dhHoGaZm?=
 =?us-ascii?Q?2IL4YFxGfV5f48E52tkLjUCFo6rbVFQtXJm2QhgOqT8h3zzH9ekurBViQnuo?=
 =?us-ascii?Q?UD8FjhpbAKo764afUVuiMmpIa/iKuzqjNAM6sV7enzvlI71TBnVzHjGZgN0F?=
 =?us-ascii?Q?66mNyMsG5qIIQxDO55tUK8wv9wr0dAijc3Yw7YzEgsfeHYW5BDKCyBvmU22J?=
 =?us-ascii?Q?LIygN1GYW60U6c/uo6PZLtq93H7QFNCYMNFpn6FixNFTBGdbGJcXbv5MzOvq?=
 =?us-ascii?Q?WX2T3MBTzH2bcAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Yo5D7YB/K0L5QqS8cGxV2t1Oiz/usSHdsFDWPZdMtlbvTymVh1BWfOk3KcaH?=
 =?us-ascii?Q?IHttLr23GXkSczlQUovtxd97muNhZ/1EmWKrs6e1FBc4aSg7ziNPJUO2VozS?=
 =?us-ascii?Q?YNvg4p7DdQRfmZbaaeOdbrG6bKp8U5zuexoTUkyPF1r1WhmjRlqRnRkX3lqO?=
 =?us-ascii?Q?0Hi0QtIqWz+hYIrnTAtSVufNzsbWQfX51FaX8j+7ogd6BHx2vYTD6ynKYf94?=
 =?us-ascii?Q?cKWbV9CeaEziqn+3XoKRXrRt8e7uSdCxcDp27RcUpwjnjWm+6Y8jDEpdZzbn?=
 =?us-ascii?Q?uMsFRbcnJTM2SUJLPSWg2FzVUvsLWyuGrPrWSu2N3M7SlInflLyHirbewOL9?=
 =?us-ascii?Q?MelwxQERcsTnbeVul+iD9teuIsePepkkUdDIF/YlPVhg+MSLInJSvlEjrYaE?=
 =?us-ascii?Q?8EgBIXPGa1CkAsD20BI6v4QO2FsyfFeBdoUFbOk6abrsHp9mqSTBCAESIA0d?=
 =?us-ascii?Q?88R2Y+ZW/ErSXm4hFxkApjlzLyuGuX0/C3ah+pOrtmh3JMK0OQEH09EANNkU?=
 =?us-ascii?Q?fzd9A07c7GT6LlOE3wl1wsodI4iEwgLqjlMmOsRAbZGZurWoqFAwU7/EchYd?=
 =?us-ascii?Q?YAinCMzfVhtVYxcJ+2xm1t4KDb+rRYnx6vBiSGZ6NhT5+hQ5aQY2kQu+n61M?=
 =?us-ascii?Q?M8pHcKhB/xHEhcdYRmT0rSrzqF68cTc7OZan3gBV6QaXLBisLD+uui66d9JR?=
 =?us-ascii?Q?JlqiI1+6c7qseOB7A+qYo/FVzsDSgQCyIdQ4mB6B3MqtYjSpMZyySdHQuEnM?=
 =?us-ascii?Q?snB5LVE7bt9dJVmseWVaNlYgAR+rGFxUdyWvgegflIDZylErrGMXKJRVSt0a?=
 =?us-ascii?Q?yMj8uuwVc5uEVhFO0vc4qdtPGMfryvJbANIh02uCPWQuebpKS8i7BmVhpe5+?=
 =?us-ascii?Q?krbnMIspkwQOWUaVfsvm+yHNSCYzJcv9Ah5nMTBTNIc0eWXkD7jcKe9B5vaA?=
 =?us-ascii?Q?zUkeaut0x3pl1WSswKZC4/Mqw+PIrBo2F9wqDo1E5AaenusQvBBmm3e10giX?=
 =?us-ascii?Q?C7b2QtmYxXmbwJSAhbQD/Zss+ixJaFkUC1/CYfp9HgV2kpFlsEo7Jw3Uad//?=
 =?us-ascii?Q?kdNx1KPP/PPsvNUG5VQDYMVDuNqWnULGtg5DsnB5ZA9EOsSlQN4GeZcWsuDw?=
 =?us-ascii?Q?Zemrl1WAjkSj38WLsgTh7bD+8cAXb8xlmo+2rrnFLaxN8i1DAVh5dDOIRsOX?=
 =?us-ascii?Q?Co0bGyje5IzfrVL9/yzlSduRYxLxFh6KA85mXkSJ3lpILNVFfdKpXVK3v0Tz?=
 =?us-ascii?Q?zEDS508fNlZDnjGjGHQVdNHxz8QzjUqFKrqcE6Suymnj9IxElGKOXuNkHgq9?=
 =?us-ascii?Q?/I3TzGHyLfk3QPIQeHOCOpBIj/MN55PPnrXSyyV18/ARMrZNaOks3fGkPcMe?=
 =?us-ascii?Q?N19egQj1dZbFg4hFMfVwhqyILv0oomyp+gknGubcz0uctC0i7bwdlLOw157n?=
 =?us-ascii?Q?40KkbKI18xxQMo5C57i8BkWxnr4+xNKI61gyg56yqNlt4zk/6smyHEl3xquK?=
 =?us-ascii?Q?d99eUXTnCIEGVOVpvLwTE/47SdEe/DxKe94daPpW5OBuiAF3ymDQpYe6F+y7?=
 =?us-ascii?Q?ZKB++m3E04yie9STY/hczL16lGUm4EtazrMOPqB0hlaQYLVW62WofwcRNci0?=
 =?us-ascii?Q?7g=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f63ba0-7d1e-47b3-c48f-08de0a17dc0e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 05:17:53.0796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEBEq8uaAxQqP/UOk1WQiB0BCJUzhQBMSTcQml4Ee4vnAp/e+quHLj5Vh/WdoKWPUymBLPDznimfFnBLMd4OZMFHisEKuvDm39zK5emN+sI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7450

Agilex5 uses the cdns,hp-nfc binding for the nand-controller node.
To support IOMMU functionality, an iommus property needs to be added to the cdns,hp-nfc.yaml binding file.
This ensures the device tree binding correctly describes the IOMMU association for the NAND controller.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
	- Updated the commit message to clarify the need for the changes and the hardware used of this changes.
---
 Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
index e1f4d7c35a88..73dc69cee4d8 100644
--- a/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
+++ b/Documentation/devicetree/bindings/mtd/cdns,hp-nfc.yaml
@@ -40,6 +40,9 @@ properties:
   dmas:
     maxItems: 1
 
+  iommus:
+    maxItems: 1
+
   cdns,board-delay-ps:
     description: |
       Estimated Board delay. The value includes the total round trip
-- 
2.35.3


