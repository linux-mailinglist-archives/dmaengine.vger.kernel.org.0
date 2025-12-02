Return-Path: <dmaengine+bounces-7476-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 60ABEC9D5EF
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 00:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A6B7D4E4ADF
	for <lists+dmaengine@lfdr.de>; Tue,  2 Dec 2025 23:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EC1322DA8;
	Tue,  2 Dec 2025 23:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="RTjJQEjz"
X-Original-To: dmaengine@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013039.outbound.protection.outlook.com [40.93.196.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8765631ED7A;
	Tue,  2 Dec 2025 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764719280; cv=fail; b=IX6FW7iOFQq0TSYVpuz7SZaZZFQ1HwUl5hoja/EwAzluY+TTuI2vSXdBpW3FW6NkvJuBd59pW7FUV0BNlUHBuoX33WB1MYJ62fwZTwIqfJ2AorB/OyxxtTeC7zguKRaKFjsymhB7Fx5/ANHRXMQ6qQ5wVbcJ0Ucsde0G8HPBLi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764719280; c=relaxed/simple;
	bh=JZNVdJmJHMC2vLPPjngUaxz8B/HoPaFJIduUcQq4xz0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q49ilM9QSiqvl8ySC+FrMnLuZnbtMr5oF+UymPXGDpHG4IwfuQ+xxXNlycRi7QIgryFcxuTZfZdPzelqcFwD27xd/gMST2l5nG9CEEq4C19Z5ZLRvjFL9GBTgGiNcg9vvKSsYwSbftkG1agmdZZOt8FawfCvP4dOUTzeHFWInlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=RTjJQEjz; arc=fail smtp.client-ip=40.93.196.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGShVRE7INErIBTZLHMr3hTeD8Dm9nolOVksvIHx3qPDBa+T07J8aQNct1wx8xHwaka0d3A5ynXmxBrtZ3xtO31q+xewBaXAJGaPGzstX1fZoXXm/XPLOWNohAlxsdfiQBe2rrb1j+63nKaK6Z5vBkWHqnkaaBt3+nmuaquJ91I3LE73XUBk/sQ+jGV2E3fJNQ5n6XBKlDGUgle9qe0YAi7fhWc9fh32f+10YV6jIDjJ9rZJshGGO6nJiobSIv3M+eI1clXz48QtcIuGoMxpdKzMNiIb+A3yLY/6ErNUXoD5OmE0rvUWZjAJ8KtPtVroo9vpyHjrsu7LeqojbeB6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKQOJs3GEz9UMdwN4SnVTE+ioYnXKLdjQnSH0CIcp6k=;
 b=JCV+UaZQ0GnOh9i85UOYz9V1RLVA4a0HTDXzHgTwVZgutmUlDVFUeLBMSJCtc85nmKnzRfm/tkT+uQGBZbSheA0mred5AAIiYMlfHrssB6H9x/mdQiCg5bGVNTjJdwLmW1T29Q6u22fFOv5ovphQ6kn8NxEyqzfy3h+ghL4gU+1Fyl6e8EjnxxJQyEdOiw0qswIH7mcq1k62Csi3IcQtgRSexduCoDOJ6RR8xSqcIb9k720D2VZVMWMvrgnaDYg+RK/jg1Qi19NtzCX7Nngdwe63KNdaABXgh7NsyVmK7p5bJj6h5CaNdjhl5kq4Wtv06mclcIYj2TqiP7Il95pfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKQOJs3GEz9UMdwN4SnVTE+ioYnXKLdjQnSH0CIcp6k=;
 b=RTjJQEjzmdgH0K0hPC16ytyLZ1t4bkhRr6h1Ll3wbZwzQ93QpC7rS1YEmtjhaH1P/br6hr411VC1sIy/iVwwT6kxU0yWkISVAtEHZce/ypbzKWCUZl+vD71wMumdPHVQ3o1OjVn+YPZn1qxXUlxy6wEPBP4dC6YMXsLhmFDgsGBxBpKJpOErCCxYo479DC9VpbMeZeB2VEUnf5kvcQpncmNgrBoLfe/EftrpWxVcd118cJWIZYhb928o4Qo+kZR4DWJl/INO6guOynTWtV8LOKIM5HvQuovUWJbLuIe4Xx5RV2HzCjC8sY/6gLeYzi7ztMWsgFLdY0oC0hC4s4kLvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA2PR03MB5689.namprd03.prod.outlook.com (2603:10b6:806:119::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 23:47:56 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 23:47:56 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v2 3/3] arm64: dts: socfpga: agilex5: Add dma-coherent property
Date: Wed,  3 Dec 2025 07:47:35 +0800
Message-ID: <1272181d9befff75281363c753e9ffd6d796aafb.1764717960.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1764717960.git.khairul.anuar.romli@altera.com>
References: <cover.1764717960.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::7) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA2PR03MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cf39412-dcba-4043-2ad2-08de31fd37d3
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fkL6tUpltXa8QZdqqiPRuu/YzlP9w5RafHIOXT73j43wb2OB3186zH0DCD8s?=
 =?us-ascii?Q?jgJxmzaeZUU2gZRfyngxWZHL80eW4uVSVvf79tXEqKlbfULNM5ZylXIZFAJr?=
 =?us-ascii?Q?GjS0tL1DcNk1fhV70AaR3UO2PBpAsQ8dFPH4x9LpsxK5r0icX7L9WANG/yEw?=
 =?us-ascii?Q?jqqFSDQIM4D+YD5AXYce6uFB7P0PtJcfZjk4dNC2DMfjP8SQeZ7a1NimDy1n?=
 =?us-ascii?Q?Fxq4xaoyMaNOq1NS0GGGjIfx1QQ3bAxNrxTf3NfvbVRsvbL3Mx6qLM06P7rH?=
 =?us-ascii?Q?W0kVwSPwTB4eqd00H+qXQvEdd7VFSZiXTnD+Xznkv8uqsAxMm/DGZH7EazEg?=
 =?us-ascii?Q?cHZH33mxwHzAe+Mx5pieVZSaj03aIE1JyCanIJgdmToyi5m1edPtmXLEztBY?=
 =?us-ascii?Q?OQ9DZOKuzcPoCRGyFw/v02bKrU0SUBU6KfFGAmiKcZhnYrWJXE4gh0cxLPk0?=
 =?us-ascii?Q?iBpm1weCNyEped18SlrLnGbmMUDSlfNLDm9XNuY57jtbRDEL3PePjvsOgyVk?=
 =?us-ascii?Q?iGJzg+O/oLhSbrR+RBvHf6EYTtojqhXCWGt7jwk6qXTy/dNmVVwEZXLbHJL3?=
 =?us-ascii?Q?R8pcUMYInNmMecyUdNHubFBiFyvNqgdLAJ5Hv8p/K3j1fzd3ajogxBfJ3JOM?=
 =?us-ascii?Q?E2JMNZ2rpQ5VeNn51CGDmSTmhGMX0Lijlkr3CC8ly9mmYj3s5G1UNihgbcTq?=
 =?us-ascii?Q?zC29aGcuj5l1FFWB1VgLuil5AgsBO1JiI/Al6QS9z5oBADOqEO3As63EF6gk?=
 =?us-ascii?Q?zq4rqVdtcTGpiijy1slWcwEnooAWhIOPN1CCLYmXWwt1thldJPnWa6VibZ/h?=
 =?us-ascii?Q?fT+csIIfhuroGgyr0rOUXY8iWKTpHcrySufUrgd4Oq634jEXxIZ5u9eWczXQ?=
 =?us-ascii?Q?UrHNKY9JZU9czZ78kJo7LU3Zw2rHtsbPQ3atniV/beDlBuCa1LRLxsod1ONl?=
 =?us-ascii?Q?n5jeiN48rnKoAYAwa+xbx0BkX8smfOoTVOxhRngk9xyQj5srtnP+aiYBIP3V?=
 =?us-ascii?Q?FyyViX3ef8rOThSh6OmzAQHtE03vHG4nkrIccGoOwVpdwOVvbc0Fx79QZi3F?=
 =?us-ascii?Q?Zhaq5Du2TU/ZLmFtBBCSYHoU5h4NiPv8Z3SguE6aQEMmSlStg77FWDU3iwrS?=
 =?us-ascii?Q?yiFkUSjReCaHkWRvit7/9fbEk0EqN34Ql/f4H1kluE4m1E+RvmBTphNL2FdK?=
 =?us-ascii?Q?+KnFxjba/tqE1bYIKgUXVAPSF4FnOMyFaAilOoUGBUNAB45VXO/gLY3B3Ttx?=
 =?us-ascii?Q?KoEM0Vy1oeRMxFoH1L5sEE563a8IWVOU0G1JDOpnNJGCXfEQb+T0Ys1a5apC?=
 =?us-ascii?Q?q8bAiOmi7AzY5tEl3DOuC0aHFUpRYRdU5WRoy5SbvJ5YId/QlLp6vPxAsmk4?=
 =?us-ascii?Q?ZlBxIhqvMKMN7NRxfHdC/ATKzRV2OjmUXtQyaT/8cfzyE7u8pU+v0obBWaMq?=
 =?us-ascii?Q?rf+bXht5H35Gr1Tonkv+sccJ///OMS2dWmsx/N+5ajAlCIgv8XzAqztGZ9G/?=
 =?us-ascii?Q?BZnuWyueJ4Xz0M8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4wU1gzIxzatrmKfHKioXi+oTyioRg1Psdkq0Bs7DLS40q4N4SES6YKaKgrpr?=
 =?us-ascii?Q?CRBegm1D+XhfJpl2sXfjchS6ot7GAWhcAgOtJzF8DkmV2UeNYCEkiJMz5+Dn?=
 =?us-ascii?Q?h4Mbqrg024m1fsKiSUoS1vx81kAC1Ok08R42BE4M3R+v1xEIh7LwIgYFV6m+?=
 =?us-ascii?Q?/AmX3HxTx+HDSX6PqQbr8ZWGbBqDS1iHsj4rFdBZ+S6DhpV+c8xvq9m/0QCU?=
 =?us-ascii?Q?9dYqvdfPg2MdNeW1+C+j3btRD1n0SfpNwofon/cKy7bsucMvsBssmNT9xLAe?=
 =?us-ascii?Q?3dZ6LCzHLyvwtXqYh6HVWTKQ8BT3TmQm9J8LGrpD1xCkpS/9B14ATwFJG5x2?=
 =?us-ascii?Q?ecFTjo/O/NGi7oUuG8tPmkQABJZK9eE2ad9Ge+MGFWFaKLF8dWf6fmefm9x7?=
 =?us-ascii?Q?VjpKjZrtX7WRMGXUdIC37EzmA8ppzZ1nfJuJjOaDKcgGloXvHYavVV60Ig3k?=
 =?us-ascii?Q?BuRD1HMeciUkF/0liQ+D7QqgvRLm5H4P9BEbrpafAmjemF3ZIuEUMk5xy8sX?=
 =?us-ascii?Q?za4/A3YHvI3KlUjvjDzg2BrwN84/+nZ0jbZocOqEgi6fv0o9opNllmKGw7mn?=
 =?us-ascii?Q?IWX9ia7K4bHR888aJarjAnsFCskS53f7HjnKVFaxjpSQ0/CPrJ4OQVXV9vVA?=
 =?us-ascii?Q?D173uzTe+Ocrfr/sEN4wVx2rT+6jk+1ZexpTLRElNAGMZ9omQpmbK0DPclwr?=
 =?us-ascii?Q?5NijCy7ek5/zc6VEWMcxtZ0m9vjOCF00pd0OVRk4oJyb2WBmWzUUVh/0pYqW?=
 =?us-ascii?Q?ZlVxzCx3Z82eE831Upqa4hAcQdhL9UC2T4AF49xdqVtCnwa6z5c0CnOeUm5B?=
 =?us-ascii?Q?/KzzN5J4sEpsGZ7WonLGS1Ih3yVIfmJPH/Htd+ENTCA1y0AeH3VgK+EibIK8?=
 =?us-ascii?Q?X3gcVvC/lqf5LNBFY4TvV/qllRz7wsxRwzPIsB0JoxarSA3DOoYsU0Z/0uq1?=
 =?us-ascii?Q?6I2sxqPyOSQd78CkAJDa0275+NwQNzBgMOjomEQctSvA+8a0u6IWdaL9aJ/J?=
 =?us-ascii?Q?2E+GcV8zgbSnNsiOOZtIHtgVFucSuE9lmYVB18HV23+jM4lEOMxmKQLWZLzu?=
 =?us-ascii?Q?9SiP/gUsFvwc9+Yp/pk+cCgl/jjHGx/2l7dDIapTjJAfyPeAn71by+O5Mk4w?=
 =?us-ascii?Q?Xwv7tx9EHoXL+WwUGy45YBigaEGgiGhVY3R/M1RfHVpjYyWgvxUmNFWsZHz4?=
 =?us-ascii?Q?hAU6EYm8ZGog5NDHrxIOIkVOcNoR6YOVXDp6JiyCIzJ7RBVdbVWChMU6cDXF?=
 =?us-ascii?Q?2LTZyWszAgf5PdotJPyMk7TJkVXot5ig5FQhLBcJNrH7zEbOW0pGG6/S+T38?=
 =?us-ascii?Q?Lbj985W4GJUtXoNZ38PC0PDc7AUoitzSAgpsuUX79zqBTVWC6miff7ZvpKRp?=
 =?us-ascii?Q?vvxy8ejj1I0MuSwno1Hg77vTS7PKC38409CSp+PXurhYcddT9pXf5up0dDDq?=
 =?us-ascii?Q?XwJTn6erfAE1C01C1X1yIT0LUpiJG8OUkw1jisKtfNGU+RVo318J0vNPECDV?=
 =?us-ascii?Q?KRtVGhsTWqu5shPNHDxWyw33UP7QrlS60E2Ow6ycmqo+6zJGTgvDedErSEi+?=
 =?us-ascii?Q?Cs4FtE9qYVp1Lo9icc0E5YcU7cTKeDb5wC8K0tMThuwUEi74hmLUfM8urYbV?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf39412-dcba-4043-2ad2-08de31fd37d3
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 23:47:56.8703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dkcs7El790aS1waBC3fv6Jeq/9dlDXrf8sUPmb7EhmFz9lCKJSMff3Ih/2nGycIjo/pY/ZEUJICAaa7PiunLoyp7tarc/pyVeR7gqNWWefE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5689

Add the `dma-coherent` property to these device nodes to inform the
kernel and DMA subsystem that the devices support hardware-managed
cache coherence.

Changes:
 - Add `dma-coherent` to `cdns,hp-nfc`
 - Add `dma-coherent` to both `snps,axi-dma-1.01a` instances
   (dmac0, dmac1)

This aligns the Agilex5 device tree with the coherent DMA-capable
devices accordingly.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v2:
        - No changes
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 1f5d560f97b2..d6a2fe445fa6 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -324,6 +324,7 @@ nand: nand-controller@10b80000 {
 			clock-names = "nf_clk";
 			cdns,board-delay-ps = <4830>;
 			iommus = <&smmu 4>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -351,6 +352,7 @@ dmac0: dma-controller@10db0000 {
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
 			iommus = <&smmu 8>;
+			dma-coherent;
 		};
 
 		dmac1: dma-controller@10dc0000 {
@@ -369,6 +371,7 @@ dmac1: dma-controller@10dc0000 {
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
 			iommus = <&smmu 9>;
+			dma-coherent;
 		};
 
 		rst: rstmgr@10d11000 {
-- 
2.43.7


