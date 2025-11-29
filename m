Return-Path: <dmaengine+bounces-7412-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B70C94304
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7478D4E6D46
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0FE31ED6B;
	Sat, 29 Nov 2025 16:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dKoz89wZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010018.outbound.protection.outlook.com [52.101.229.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3091531B836;
	Sat, 29 Nov 2025 16:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432299; cv=fail; b=I65wKDawaQsNAa5PeDPcE2zOBzJF2K+nezBf/etO2D+wwyRo/ByibDIoWGuJ4ilTv2Zv2en6eSGTMr+yF7JCrAj0BIaljp0Jm7QS3yowX/bpUIGuWRuRd8SPVqTjULhdGEYQ7opWLM3QjloX6ek8a2oeSGLEZzIvcUNDZCIwUnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432299; c=relaxed/simple;
	bh=BTPApRyZJmpuolARcYzgU4PX+4cNVbWDDjDRSYLI6mU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sld3LyKZsnOX69+Xs1gePNDG0B8CLnQOUXQ9ydroBMMUOh+y20ma+szNOu7RKcbMpXSf4QC+RvKKz2+4Tmnr4GMugM+RMMCFdQwdlvISXE5OnUY/AgRiJBbpeyqiggW5VUBS3It0tc5GCuS1WyhUUec6vmsQtQRA+ZbVNTewuG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dKoz89wZ; arc=fail smtp.client-ip=52.101.229.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V32r1ByHUrDgEjY1PbBTseCWfHLLiGbUuLn/w+H1eVWfPJWu0CK2YWnhRuVvwLr7sWpcydBaEAzYugFGmc2ZkYk8zvkuVoEoRMPonqbntgjVCdCSMZQrSnQ13TCaCtDATEUS1Nr4rJqGuwOfX6bYyyeFthgG2scEghDEr3fYNLU985OI5tbVWGTT5SaTUCGq6s3fh50x0NTUBUhks/0pLvGE0YRmMFTe/iHbE7e6A7F9znxXN/Vo2JTNJAMGiHJF/YDdLsBnUXcdmv7wLnJ3SILZSZhpXPLfuRT2NXvj1Rh+uUnbThRJR0/1FATJdZdeh4DVgdymleFRBGM4N5UeYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYwdgmOesytKLm25lCDQepRA+HT2jpJ6Y3eMeiMHCOQ=;
 b=Z+6oOd43yDun8api7JvbRRnSlBKV7gmDxh+2Pn6xoiZ6L+2TKuwYyjnIYTk0VYqVieSvVqt4PGKUDPoXSInHAe5+nSK6gFDuvtg2T9nHj8dRYJSDLRt+YDnLlzbMDwDN/4cEbeKEmpiFQJhMnkegPhr6kZoGeD3+Cxkkd9TbWTcsnOj7uyn3c4ZUdF/eZ0vMjy/Y9oD1QOQTJ+sZKKr3jauDrcTaZk+9dv/5/wLPdEDOEJFGgF8u8G7wvzr0ktJdQj1M8h+wcYY7PlE/rtUmYkFRPR12B+Ale1I0WKRAlBg5XW0/GmDkIluqkzikjayNemTClpC36LfkGzioPK+9rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYwdgmOesytKLm25lCDQepRA+HT2jpJ6Y3eMeiMHCOQ=;
 b=dKoz89wZlx3ZOVD0ELotTsYrmsWj8vHV7cdDnDywNgDwmYJ/SANOb2Y4OQFESnoQigjdPAeDekis1QkrRNNLWHAKLEgicPIS5ZUJqe9DQM6hmIQBL9xhmEjAty5LZKSXONQlHt6xDUlGAiyDijP5IclZvs0+rxxbJqrjdlMcQTk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4684.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:46 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:46 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 27/27] NTB: epf: Add an additional memory window (MW2) barno mapping on Renesas R-Car
Date: Sun, 30 Nov 2025 01:04:05 +0900
Message-ID: <20251129160405.2568284-28-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0105.jpnprd01.prod.outlook.com
 (2603:1096:405:378::19) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4684:EE_
X-MS-Office365-Filtering-Correlation-Id: 2248c63d-b741-4b4d-53a2-08de2f61047e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vCZTZdUfTiiZ0jNF9jHjFOT99KLwcpzflsokJUWMSeodj+npsjCzkFAHYm4c?=
 =?us-ascii?Q?2Fo7yz5pxw2tDSiJzt53fNAwvO6p5c9Sw2EEzVet8PBojiGGHXgiOTZEAtng?=
 =?us-ascii?Q?nUzbZ0oCXWEQocry3QqMDWTenDxsSvLbJt+D63HqnsmhsZCGAkjonMoSncmC?=
 =?us-ascii?Q?jkmvR6Z/fcbH49qFh2dEtlqEx+uAXX6a51MgnUiKRJldyDhOC/DUesVY9x4I?=
 =?us-ascii?Q?S6+rBeXyZCEJHN/7AXqK0ULvZ2DkEENnYSap+tO9wjaxmiAX/jjfFSH+Z83l?=
 =?us-ascii?Q?rKnaNKy8fmxLwQG/dPAracOSnqI9C0PrrHAjKmAAcDiTnnip82jc/ctCtblm?=
 =?us-ascii?Q?cDzmC/ZGE0tL7c2sgkVMFSbSzvjK8vxXzDbhQmhEUtTOvEi27f2+kJSk/fFq?=
 =?us-ascii?Q?lHuJDjGuqIVsXhcfQqqoDOawSslgToRi5fs9s7Iun1lWmESkp7G2oQd7oBUs?=
 =?us-ascii?Q?HpYxRKHoyeCuXbHDp4t3L13XuEVTS/DaJ1HhOw8Qke8Vx1nXAHRvY59QP7Qc?=
 =?us-ascii?Q?PRn8JMmwcDouU28oHJDcf1bDXIqQbyddNd5HiCBALDqbFZTABP2wB35nPwLF?=
 =?us-ascii?Q?iz2J8pjjcgdzAh3iFdsHLTg0yt9YN4qZQTwSSPh1YNG6/qJ6MS5YB30Wtz3c?=
 =?us-ascii?Q?bH9eWaJHzbuRGi6J/1t2G1pO32bMSgKyTgyc4KEkJi/cfia1E63qEpmrINk5?=
 =?us-ascii?Q?sjqnW658pDe3Klogut3X7Pec8W8tPlInL4gywUNKTqmiCeha5LUQ2c4Ghzhb?=
 =?us-ascii?Q?wk0ID+NFHJYVo9LfOKI70cwXEIP8S5XqrdcLn3cF/WzLBhYwywq61Y50h9LJ?=
 =?us-ascii?Q?j4bWSNNYExgBOVr/s9nNNp0AVeUNugWKQQ+aDGtYviikqVOCZ6Wurca1TLxz?=
 =?us-ascii?Q?fUmkgvzYLBlUcHHbgVoYeFxDHftHt98PfqsROzywTEqWBMni2sVDMizDFUKE?=
 =?us-ascii?Q?D1f3o9Mz+003IFAILEcC9uxrEzyC6dF/jhO2UplUNPS7JhLzn8fLqvylAmhX?=
 =?us-ascii?Q?bxSa/VJMQHm3fIGD0LXLrtLLXkAtrtPkCpLMabjCsulFDqCYRHqK6pMwWnjH?=
 =?us-ascii?Q?9RpZpnHMLZeQajhn8y9nQSqNwi49mEVLNWd09GRZAIucOt2Xl9Y5GSwa3zgt?=
 =?us-ascii?Q?78m4gJCfn8ZraLkazFnLnVIobwoSW9kaRYeSi5cV+r7jc5iJrvjMM7UDZ1Iw?=
 =?us-ascii?Q?wHtr0+jKm7bgcN2IHA15FZXcnyoAbmGLPTM393l4HV8DqpKWWqGaS3SXOc1/?=
 =?us-ascii?Q?cBD7ekLA6QiqbAEItIu8bhvDRnujdesl2CGa5Jq0nXE0JEnRXc6xznKcR1Hf?=
 =?us-ascii?Q?IxSUlF6QnrOVGkkI/OCH/3VvT5UEJjP+PB2cKcr5xuKpXh/kqkjpIgsqi0k2?=
 =?us-ascii?Q?dd83F/zCJFxcKf38vp15u0dx3Rnx6deXe2tAnowHLcond9elxZYglDk8oseU?=
 =?us-ascii?Q?6ZxIkhUD5+8Ftzo8kf9HknJ9nWJsa/8/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lBGAeuGUEq4tJjOYofTD+WZWe/J7BjB9YM6RrnPjkZG7rBfO69kJiw8kufc2?=
 =?us-ascii?Q?eVQKYEI2AGHfq7JROJrEy2xeZwrPP7V2tvPRZErwiH0MDrjSM/n4q3BziEda?=
 =?us-ascii?Q?/VFCkc4wgvzptgYBg7G2Ivor+McpRQsU6oZlc0xQO9dgwanrJp7cWu5hP1ia?=
 =?us-ascii?Q?rl3KOU1zE7U7NhgXld646ZVrck+M9d+BpFkTXKqvHnZm0/NBuGYkCU1w9VWm?=
 =?us-ascii?Q?WMHK3zcFUwVtLXDAvyCL4YHo6doW255H5JDo/ds924+ilsE/JSrkKM8l0weC?=
 =?us-ascii?Q?EAySRUTTQXb0N4QlMumluU9JWC9xHHIqiTy7yIVAYlIsqWfkjilsAFzwbr8i?=
 =?us-ascii?Q?0BtUAgRD9GABHwL5YoCJnL74CCpi3e6ZY3s1+/iUPOd5sx37yeV1vhXwcxVV?=
 =?us-ascii?Q?ZVJu1AesKub31dRx3Gpc2aV7nhd8OYNgPkXviYG+fy+pwkg/Z2kyrCy1JMuW?=
 =?us-ascii?Q?ge1It0m92yoXzQv/q/prR+/1ilNXkxWGcZORTshv2+v6wBDXqUXCKmwC0RuB?=
 =?us-ascii?Q?62DdQD/XgcziHtXrrlq4oosz/RKn1RmmJKJs4qCwf/HNueZ/uy7O134MTeMG?=
 =?us-ascii?Q?ZqkaEzEjHtdsHCGbVj69WsEhms9EpSBbtUkYrcUPHoIit4EksGGeuG+aqKUn?=
 =?us-ascii?Q?8z4XitbmCROkuVt+00QOtxupk/Z9AW9dlJQM3Wnh1hSgo6BKMywifPIdBgvZ?=
 =?us-ascii?Q?FeFiMbDL4IJp3DJCPBx6hc+ewNwpCjMlJUBmi57ZH2gFcSP8gJDt+Hk/ueM6?=
 =?us-ascii?Q?KLpx+W01/q9YG6z1H/2uwEvVkPbDqGDXeBFZKJmOOeROti3DkbecaAM+Ax2m?=
 =?us-ascii?Q?ObUbqjSeniFbxN9RnNJbKdINuAX5vLO5m6snowp/7fdKdCKZhorrn5QdPBvY?=
 =?us-ascii?Q?eY6vBLtEyhcbk5hTRyQr6O3O+OU1rm6oPDPUimTDW70sdW/cdgY7mS6Ail5v?=
 =?us-ascii?Q?wcCpSydhMjNHVG9gNp8ddTMpbTxFGdvyLlMT5cjtAOurb2LXaOt2CDKLA3Xj?=
 =?us-ascii?Q?4GpJQBhzS38xEdMq+hWIzL/24hIxe5ltpAghsAJUeTFYLB4QQToLqw9ockmq?=
 =?us-ascii?Q?UDOCFIOphCEN7fOflWzbBp2hgbaFGqBbJ20RkpL6hUxyXiCy7cBtPpV8vNT8?=
 =?us-ascii?Q?KrVPmXGO2Lo7N9KoprJc2Zmk6guPfniGoonw3CioAtK71hoFd/MkVTr08QCW?=
 =?us-ascii?Q?JFYwILorWXf9Srm7wbyC8qTrOnXDCLx1YWwQ4h03lmqrt6JL5QC30dneFwL1?=
 =?us-ascii?Q?p924t8iER4KUk2gOJM4CL3r1dcnAkwlk2/es1BatwiCXpJQ1NTiKmsFBEQwL?=
 =?us-ascii?Q?tR6nFCDAA9yaMUCGgbHuJFy5ZbdFZXt4e2HjwhSumfxYeSsFGv8urhG+sn8e?=
 =?us-ascii?Q?c0VDpXzBtNKBMVQXFP4ifSXncCRPZbz/+jV8G2zuEBn93RW3tGN/ovSgnGxV?=
 =?us-ascii?Q?8G+Nz7OSHpiQ0u5KHu67ZbWpIDcklLLbMaJ1Ra9F/WhGNuRZGDsAdqlAmU7n?=
 =?us-ascii?Q?GpQUBz+nMZZjbwsXsyDa30iqv2PfMCH3xTP8EzFIePRsacHl5kQg5EQCO+25?=
 =?us-ascii?Q?zoWyLTNrY/+8/7JLv+/m5d2vJjpmKEUwDaohZZzvbEZtySRPOwvr0HMv2nBX?=
 =?us-ascii?Q?04Qf+mgbuaCqJrXYu3Nae18=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2248c63d-b741-4b4d-53a2-08de2f61047e
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:46.7559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q6+nD3SihK1vJcfIO6Vz0PczSJjxkvnXWAzrY3Tg2q9nsu3sDw3e3ASN4/QV5NtnHt1AgSbK1XEf0q41HrL9Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4684

To enable remote eDMA mode on NTB transport, one additional memory
window is required. Since a single BAR can now be split into multiple
memory windows, add MW2 to BAR2 on R-Car.

For pci_epf_vntb configfs settings, users who want to use MW2 (e.g. to
enable remote eDMA mode for NTB transport as mentioned above) may
configure as follows:

  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
  $ echo 0xE0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
  $ echo 0x20000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
  $ echo 0xE0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
  $ echo 2       > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 21eb26b2f7cc..19a4c07bbc8f 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -792,7 +792,7 @@ static const enum pci_barno rcar_barno[NTB_BAR_NUM] = {
 	[BAR_PEER_SPAD]	= BAR_0,
 	[BAR_DB]	= BAR_4,
 	[BAR_MW1]	= BAR_2,
-	[BAR_MW2]	= NO_BAR,
+	[BAR_MW2]	= BAR_2,
 	[BAR_MW3]	= NO_BAR,
 	[BAR_MW4]	= NO_BAR,
 };
-- 
2.48.1


