Return-Path: <dmaengine+bounces-7759-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 101A4CC863B
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25A04301E34F
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF51A33C190;
	Wed, 17 Dec 2025 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hPgW/alq"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011052.outbound.protection.outlook.com [40.107.74.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCB43358A4;
	Wed, 17 Dec 2025 15:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984585; cv=fail; b=mkctY0TZTT4SFKeD8ODYZ71SSo+ATLsXmjX6+9zXqoBowuo5Ji1FXinRICeOLOiKlBkJoSDVYw4yooCRy5eLo53zQWdHHAabpO8wpu08hmHxcaDWQjPfRoe1dT7KHXu50Wq3T6bWqBM+U+wXaNxw3imwG0JRnqFPxq31pxFSEJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984585; c=relaxed/simple;
	bh=dinoBCJj2bnKJQv62Qeox+djGNA5UtuTaqJ4qztBoq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SdKmeoAQvmrMskQvxpNpDQQ2zCbFlAU6DfL+mT9ZLJ9VJs8zssSAb7BoPHtZYTI5Y21f8U8/c4o4nJlNFfSJXA5UyUI83Cq5oT31VXDW3B6dHEgMoAXuED2WdI5KiVM0M9GSzH0cgk2K/qXGcIqiLIvHcdPUDL4ZnnW/s3pHMaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hPgW/alq; arc=fail smtp.client-ip=40.107.74.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZEYVSOlNPXkBt3A+fDO6AwBEtx2wTAcTve2SZfsMswLBcPWFWQhZBMJZ5/SvH22NHbyJM/t8L0XHf4vk0IdlvSayqtqiI3uOpPiysxx4VJtarNqGsPII9Sn4xuoQR9HBnqC9S5Oj1u+1i+m4N3bPUqSVJ7fS9Uf/WUJgfyvhepcTywb7l6S2LI9MXeMoqqY03lkhk6s5IXZl04fDW2ebCXozH4k4eS9yhbX7ztmHsQ/53wEfAJc2qO9clLcOLR6ODl1kJXAN180zUriQ1QSMmJngGqGu3NkhSQb3wjlSn9iitREI1xk0Fow8k/yGTYI5UPkEIyndVowczK5lvSo8QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TndGji5lg89cVye3iC5pe/TN/3ffkCrfIeu8yWxalNA=;
 b=RlqejTff++sxvm9HW9AjwOv2Vrw/F+ZhUOX+mA5F2JkGlnr0xCBJH3dH21VYZU2E8rvnq9dP8uh/iTlCNUx49CkTeyYeM+kb4gO66tKIe7FX94qoBQ4gfgKihiZalTT2WrB2MUtxcqCm6uoCaz9ffx9IJ+aOtXKzfUJCuMl+O3i2O35xSf86fVu7svRSDln6VccEfZGaOqw8t3QQ81+fplNLqgDgo5GKqsrcYssKD9vff/xEkESEk2yGtzzpZx4UsnX21q6qBJp+7m6CigIpFRzYBQNedoBQ82ZHV5tSHEO47m3pWB08E2pqQ76siBQVUopPKzw9gAG6LJmkVa4sXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TndGji5lg89cVye3iC5pe/TN/3ffkCrfIeu8yWxalNA=;
 b=hPgW/alqqa98WBiHqjMh8aDaTcCc+Y1Ziim0QRJdHjnvWyWIz1OoEQUlpdPO5LBbQumdrGFV+55P4n868OXMgL1yABhx2ZWNvbm6XH0viIpkebDjHyDfkspcycISpuDd+0dUlgG5gNM0fQXwXwzbo6EcVFxwtXAcp/9n30lPYCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by OS9P286MB4633.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:16 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:16 +0000
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
Subject: [RFC PATCH v3 03/35] PCI: dwc: ep: Support BAR subrange inbound mapping via address match iATU
Date: Thu, 18 Dec 2025 00:15:37 +0900
Message-ID: <20251217151609.3162665-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0037.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::12) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|OS9P286MB4633:EE_
X-MS-Office365-Filtering-Correlation-Id: 40879712-f8d8-4b53-ca2c-08de3d7f3907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uBoM97CjnEUMHFtSTBU4mXFVoRi3CO2qQ1IPmgM1Oa/TGaNvds+8EjVUruao?=
 =?us-ascii?Q?IwB0LBaS7q2KZGJh1/8FtnATbMQbhyBbcavKoQoohBMMijX2LIioixvhFk0s?=
 =?us-ascii?Q?KWiwTKRzQA8L6I7qMCJrkLhbeJLvxZh7MYMxwrmmcWi+0KrWiZbav8J3Fzkk?=
 =?us-ascii?Q?OdgbN0fML+bSQtUsTqsMPmva3KVBcgXpT9JDd/4W6gGVPTJwA4k/xr95pFPG?=
 =?us-ascii?Q?31PBOE9CSFQygxV3sAFCvp3XnDqPijDzLd2Tb0Rr71AtJ6H3sWfXvc7TVfDo?=
 =?us-ascii?Q?Dz/QVgVCw3YJWL7rrRcS2Fb6clA+Tzk9OaaaNeFsFUSjrjM7U2m4HNAYifs/?=
 =?us-ascii?Q?8MFfIlJLzWPm3yAu7uA4GxnP2/tpLB/MTrxbMqGgcLtJHuO76nVNnR4YdbmE?=
 =?us-ascii?Q?qQ32dCgboQmGWaTRKXLxBkYHlSUcxehZmr+C7FBlhCiJhHXa8cPw4mu9N5x8?=
 =?us-ascii?Q?UGPDOw+8MQdnWVJgp3G7kxzzg+m1pSOI3xIveNm9dece18zd5bBL6ML/HQiN?=
 =?us-ascii?Q?Cxbt2Wr3Qdd8CPAqpVsm/eCbjjjYiyRF5R4wr8aNPo5bPUD/B69+i5HcfDt2?=
 =?us-ascii?Q?94CtTmykhSiJmywjMLtol7qMn5n7bfKfsRvViKLPvCdv+K1sQ80qteavxnyj?=
 =?us-ascii?Q?S9hMysy2w9UhOgbs7SPrPeKStElD9OP6CEs2XkPDtWVoVk4WnWacOUqWONrs?=
 =?us-ascii?Q?drBhnFvxooxM5VJ2sCw2qAOzKTaJCU8TxBlfW90JtempzRy1jpC/Ugaa/8m3?=
 =?us-ascii?Q?yUh6cvObXTe/Wh6hJ3vOILxVUQtLjo84XExUuxNw9LAe+34hrbvmy9Cz6cuj?=
 =?us-ascii?Q?cOh1nEswG6BHlTG6QQASzRkpxOetBKP0M8xEXjpvkhMGPPsgBKq/eULjc8yY?=
 =?us-ascii?Q?g3V+9MtmY9+aXF+u94CfnA6H+O+cTjqQcMYOaM7oYLdlaHL8i8kIQJ2g0bXZ?=
 =?us-ascii?Q?wItgxygnwkrB7vM3lUGiyNkmsSZbpiWuuxFHz1T/7IBp+otEGobCXPlfbFkO?=
 =?us-ascii?Q?f3b0a5YBCfciItX9tdMF6jUnja6JZrm88OgDz/yXk31bf6T8/lOJ/CwCl243?=
 =?us-ascii?Q?hFbS6Bwgw1tPiyJsy7fl6ecWIB05vOfJ2Q7xKn2FM13sh7dZz7tvpS7SfKz1?=
 =?us-ascii?Q?WHjgs/d7lVKQweS67SsrqP/uQfTBx9PCYE+daVEjkJK/Qm8dVPBvnRtLzA0z?=
 =?us-ascii?Q?tDbAOSuqQYlFr7ckF7uWRPzzthhR84UiR7lNYJMr1paoXEgPUf+ZxeNpmgld?=
 =?us-ascii?Q?sJ2XOt7PsaD/r7HFldcaJW05wRH6DTH5Bedm3l2uLbtG9d6rZ24NAMalHsHX?=
 =?us-ascii?Q?g+EOgdKHily9h2+Ngh2oQfVdNSIkdfBGDbEIRlPvHhUPHRACyJGXWV5CPhFQ?=
 =?us-ascii?Q?qXL5EdaVFGwgvNGMYEtDNeyJ2vOLFEyHRFYX54MN1R6hyURpcxCApXafSQl0?=
 =?us-ascii?Q?HJOHBL2gqWWEd+bKZvBXEAEeEqUSYReb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pi74Wjy4cO+fJjw8SZ8R+XjjQfmKdkYChZQ8u5xvqPREhP/hfoIBY+urDe1E?=
 =?us-ascii?Q?YAr9eo/zFYS3lu4jc8o2nOv5Dg5DrFct8OJftPu6g/tkQH7vOovkAvAcxqCW?=
 =?us-ascii?Q?tqwqamhqArvn1ub+VVnQhy+jSGcHlyQdSME3gRlsCT011/jCQhQcgH35b4wo?=
 =?us-ascii?Q?n8LhnGU9SBFanuM/Wc8d33C3SJA3jqPCXody9rMUmjXCz7ZxqNPnlPUU+xtu?=
 =?us-ascii?Q?PRbTgxXoesMky1kzIfhS0514qGRDfwRLK0DWTs4vHhoOC/x1fTnCZ7JG1ln1?=
 =?us-ascii?Q?Qd1NBvYkBQz6q/pCyywn6J4genCNztCori+ujXMv8Xl3QMPsYppIgOAtOgg6?=
 =?us-ascii?Q?OzOhJDs22XrbGKLYphzFol2kamkGKpXDhes5wiokd+DFybFY9yKPmhhOWgUz?=
 =?us-ascii?Q?n3wYyKA9nFV5kQ+vZQrW/2LHrGkfZbwoeIEb3r4o0OH3AyTiCXgq90/318Xe?=
 =?us-ascii?Q?nqbp3xAgbsuE2FuziaDP2GwlqaWWg85k/S5obiLkNKqz2z+QZGxgE48rqRXw?=
 =?us-ascii?Q?qCFHtiM4jG+rBbQXI1I55kEXSdLIP7ehX8jBQfAulEAzpFDLfhp6dxv/g8H1?=
 =?us-ascii?Q?5kJQVOUmWldqlIndBlcL9NEuO4ioF3d65PhpnSLqKKhUuwHrFZqbXpV9JUEm?=
 =?us-ascii?Q?xLH6maqC75W+YAyWBAzC2L7QAvKrJLAGXW0YZvjvnsJoNu6wyjUiVZz4IRW1?=
 =?us-ascii?Q?EGedBdvE5m+ZgmvFS2FZ+Jhv2scMKzeIgmDYXCB4k9KAaq1z8aeclsNpR0TP?=
 =?us-ascii?Q?/Nszft8IupKAxWHgEOeSHur7jLvbMoOE6NuZhuzHNh6rBHdMADNTWS2hzK1P?=
 =?us-ascii?Q?dFwfbItdhTRrTUUU5O7vw+uJvtoFJgOhB/po7HxdHMY1FO1kThQtouH2FD1/?=
 =?us-ascii?Q?FliVMSfLZauVZCBrk/hr2nZBjGpxQq0OUmibvfMTDJAHuyuNOtyhebragAeD?=
 =?us-ascii?Q?nidXKjSiuaKB6i4gPZXRFTdrXgApiwZK5nQ/5dY+ssS6ljpqrmqrAPRTNOqI?=
 =?us-ascii?Q?W8QwG/oSQS38/+nnQKYtB0/10oOLgyHdGck3mup1sbs+T0OGLngcylorCNNZ?=
 =?us-ascii?Q?cCfUl+XSyfL53A+I62L9h+drE1AUeJUiJLY4UIc6/6Dfw3BcGnPCAig2GNmP?=
 =?us-ascii?Q?WOll1OfXS87UCnEZ/SUbpJb9QGNF1SHloZciqL4oqYFh0uOveKcH52p/FI5J?=
 =?us-ascii?Q?hO8ykRIOUZlVfToGEyiv1gyJi0KMRt8jjTL+0j0+tCpwLJIIypq8RC6piNm3?=
 =?us-ascii?Q?LBj88OIosDVN5j481qWn2QsFoXRDjuaVaZQ8IFxZzX6Z9SXIZEIPi7zPsNfd?=
 =?us-ascii?Q?I3qZOq1H1QMd9Rq/bUQalIzwmXHKjJx2esn7p6gNwxoH6OjEESAE9/mcYTqv?=
 =?us-ascii?Q?BQe6yhhYV9EJupdn9xysBNlMpAQRpxQODsVCKuWBzd96Q3y3yG27ddKOwByR?=
 =?us-ascii?Q?XlcIlpb5/AuSeqkATS89jbMsPiyJWiKTMVkGXeOSKW4aC9L0zdKsYbCxW/7f?=
 =?us-ascii?Q?qS55/i4n2YqaGKmbHMq0a5TlCRroS4lyf8BruKSymO2i+9ZSXsjK0i3sz8QQ?=
 =?us-ascii?Q?2o1knVdsCn8DSw0+RTnUIp1+Ls4CGBA7O6poS3RDkBjcdY6fjSBfBCtaUPMA?=
 =?us-ascii?Q?pkWEKshy0YcBfA7Q2KimGzk=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 40879712-f8d8-4b53-ca2c-08de3d7f3907
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:16.0940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sA0RavGibqa+QmsKCLSy1hoRre9sVmc2jYsvG/SppcedTBcnH6GTRSg90lJ8zmvzDGS4qvwoPU/B8gbfnZjCPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4633

Extend dw_pcie_ep_set_bar() to support Address Match Mode IB iATU
with the new 'submap' field in pci_epf_bar.

The existing dw_pcie_ep_inbound_atu(), which is for BAR match mode, is
renamed to dw_pcie_ep_ib_atu_bar() and the new dw_pcie_ep_ib_atu_addr()
is introduced, which is for Address match mode.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 .../pci/controller/dwc/pcie-designware-ep.c   | 197 ++++++++++++++++--
 drivers/pci/controller/dwc/pcie-designware.h  |   2 +
 drivers/pci/endpoint/pci-epc-core.c           |   2 +-
 include/linux/pci-epf.h                       |  27 +++
 4 files changed, 215 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index e94cde1a3506..9480aebaa32a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -139,9 +139,10 @@ static int dw_pcie_ep_write_header(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	return 0;
 }
 
-static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
-				  dma_addr_t parent_bus_addr, enum pci_barno bar,
-				  size_t size)
+/* Bar match mode */
+static int dw_pcie_ep_ib_atu_bar(struct dw_pcie_ep *ep, u8 func_no, int type,
+				 dma_addr_t parent_bus_addr, enum pci_barno bar,
+				 size_t size)
 {
 	int ret;
 	u32 free_win;
@@ -174,6 +175,151 @@ static int dw_pcie_ep_inbound_atu(struct dw_pcie_ep *ep, u8 func_no, int type,
 	return 0;
 }
 
+struct dw_pcie_ib_map {
+	struct list_head	list;
+	enum pci_barno		bar;
+	u64			pci_addr;
+	u64			parent_bus_addr;
+	u64			size;
+	u32			index;
+};
+
+static struct dw_pcie_ib_map *
+dw_pcie_ep_find_ib_map(struct dw_pcie_ep *ep, enum pci_barno bar, u64 pci_addr)
+{
+	struct dw_pcie_ib_map *m;
+
+	list_for_each_entry(m, &ep->ib_map_list, list) {
+		if (m->bar == bar && m->pci_addr == pci_addr)
+			return m;
+	}
+
+	return NULL;
+}
+
+static u64 dw_pcie_ep_read_bar_assigned(struct dw_pcie_ep *ep, u8 func_no,
+					enum pci_barno bar, int flags)
+{
+	u32 reg = PCI_BASE_ADDRESS_0 + (4 * bar);
+	u32 lo, hi;
+	u64 addr;
+
+	lo = dw_pcie_ep_readl_dbi(ep, func_no, reg);
+
+	if (flags & PCI_BASE_ADDRESS_SPACE)
+		return lo & PCI_BASE_ADDRESS_IO_MASK;
+
+	addr = lo & PCI_BASE_ADDRESS_MEM_MASK;
+	if (!(flags & PCI_BASE_ADDRESS_MEM_TYPE_64))
+		return addr;
+
+	hi = dw_pcie_ep_readl_dbi(ep, func_no, reg + 4);
+	return addr | ((u64)hi << 32);
+}
+
+/* Address match mode */
+static int dw_pcie_ep_ib_atu_addr(struct dw_pcie_ep *ep, u8 func_no, int type,
+				  struct pci_epf_bar *epf_bar)
+{
+	struct pci_epf_bar_submap *submap = epf_bar->submap;
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	enum pci_barno bar = epf_bar->barno;
+	struct dw_pcie_ib_map *m, *new;
+	struct device *dev = pci->dev;
+	u64 pci_addr, parent_bus_addr;
+	u64 size, off, base;
+	unsigned long flags;
+	int free_win, ret;
+	u32 i;
+
+	if (!epf_bar->num_submap)
+		return 0;
+
+	if (!submap)
+		return -EINVAL;
+
+	base = dw_pcie_ep_read_bar_assigned(ep, func_no, bar, epf_bar->flags);
+	if (!base) {
+		dev_err(dev,
+			"BAR%u not assigned, cannot set up sub-range mappings\n",
+			bar);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < epf_bar->num_submap; i++) {
+		off = submap[i].offset;
+		size = submap[i].size;
+		parent_bus_addr = submap[i].phys_addr;
+
+		if (!size)
+			continue;
+
+		if (off > (~0ULL) - base)
+			return -EINVAL;
+
+		pci_addr = base + off;
+
+		new = devm_kzalloc(dev, sizeof(*new), GFP_KERNEL);
+		if (!new)
+			return -ENOMEM;
+
+		spin_lock_irqsave(&ep->ib_map_lock, flags);
+		m = dw_pcie_ep_find_ib_map(ep, bar, pci_addr);
+		if (m) {
+			if (m->parent_bus_addr == parent_bus_addr &&
+			    m->size == size) {
+				spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+				devm_kfree(dev, new);
+				continue;
+			}
+
+			ret = dw_pcie_prog_inbound_atu(pci, m->index, type,
+						       parent_bus_addr, pci_addr,
+						       size);
+			if (!ret) {
+				m->parent_bus_addr = parent_bus_addr;
+				m->size = size;
+			}
+			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+			devm_kfree(dev, new);
+			if (ret)
+				return ret;
+			continue;
+		}
+
+		free_win = find_first_zero_bit(ep->ib_window_map,
+					      pci->num_ib_windows);
+		if (free_win >= pci->num_ib_windows) {
+			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+			devm_kfree(dev, new);
+			return -ENOSPC;
+		}
+		set_bit(free_win, ep->ib_window_map);
+
+		new->bar = bar;
+		new->index = free_win;
+		new->pci_addr = pci_addr;
+		new->parent_bus_addr = parent_bus_addr;
+		new->size = size;
+		list_add_tail(&new->list, &ep->ib_map_list);
+
+		spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+
+		ret = dw_pcie_prog_inbound_atu(pci, free_win, type,
+					       parent_bus_addr, pci_addr, size);
+		if (ret) {
+			spin_lock_irqsave(&ep->ib_map_lock, flags);
+			list_del(&new->list);
+			clear_bit(free_win, ep->ib_window_map);
+			spin_unlock_irqrestore(&ep->ib_map_lock, flags);
+			devm_kfree(dev, new);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int dw_pcie_ep_outbound_atu(struct dw_pcie_ep *ep,
 				   struct dw_pcie_ob_atu_cfg *atu)
 {
@@ -204,17 +350,34 @@ static void dw_pcie_ep_clear_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	enum pci_barno bar = epf_bar->barno;
-	u32 atu_index = ep->bar_to_atu[bar] - 1;
+	struct dw_pcie_ib_map *m, *tmp;
+	u32 atu_index;
 
-	if (!ep->bar_to_atu[bar])
+	if (!ep->epf_bar[bar])
 		return;
 
 	__dw_pcie_ep_reset_bar(pci, func_no, bar, epf_bar->flags);
 
-	dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
-	clear_bit(atu_index, ep->ib_window_map);
+	/* BAR match iATU */
+	if (ep->bar_to_atu[bar]) {
+		atu_index = ep->bar_to_atu[bar] - 1;
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, atu_index);
+		clear_bit(atu_index, ep->ib_window_map);
+		ep->bar_to_atu[bar] = 0;
+	}
+
+	/* Address match iATU */
+	guard(spinlock_irqsave)(&ep->ib_map_lock);
+	list_for_each_entry_safe(m, tmp, &ep->ib_map_list, list) {
+		if (m->bar != bar)
+			continue;
+		dw_pcie_disable_atu(pci, PCIE_ATU_REGION_DIR_IB, m->index);
+		clear_bit(m->index, ep->ib_window_map);
+		list_del(&m->list);
+		kfree(m);
+	}
+
 	ep->epf_bar[bar] = NULL;
-	ep->bar_to_atu[bar] = 0;
 }
 
 static unsigned int dw_pcie_ep_get_rebar_offset(struct dw_pcie *pci,
@@ -364,10 +527,14 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 		/*
 		 * We can only dynamically change a BAR if the new BAR size and
 		 * BAR flags do not differ from the existing configuration.
+		 * When 'use_submap' is true and the intention is to create
+		 * sub-range mappings perhaps incrementally, epf_bar->size
+		 * does not mean anything so no need to validate it.
 		 */
 		if (ep->epf_bar[bar]->barno != bar ||
-		    ep->epf_bar[bar]->size != size ||
-		    ep->epf_bar[bar]->flags != flags)
+		    ep->epf_bar[bar]->flags != flags ||
+		    ep->epf_bar[bar]->use_submap != epf_bar->use_submap ||
+		    (!epf_bar->use_submap && ep->epf_bar[bar]->size != size))
 			return -EINVAL;
 
 		/*
@@ -408,8 +575,12 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	else
 		type = PCIE_ATU_TYPE_IO;
 
-	ret = dw_pcie_ep_inbound_atu(ep, func_no, type, epf_bar->phys_addr, bar,
-				     size);
+	if (epf_bar->use_submap)
+		ret = dw_pcie_ep_ib_atu_addr(ep, func_no, type, epf_bar);
+	else
+		ret = dw_pcie_ep_ib_atu_bar(ep, func_no, type,
+					    epf_bar->phys_addr, bar, size);
+
 	if (ret)
 		return ret;
 
@@ -1120,6 +1291,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 
 	INIT_LIST_HEAD(&ep->func_list);
+	INIT_LIST_HEAD(&ep->ib_map_list);
+	spin_lock_init(&ep->ib_map_lock);
 	ep->msi_iatu_mapped = false;
 	ep->msi_msg_addr = 0;
 	ep->msi_map_size = 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f555926a526e..1770a2318557 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -476,6 +476,8 @@ struct dw_pcie_ep {
 	phys_addr_t		*outbound_addr;
 	unsigned long		*ib_window_map;
 	unsigned long		*ob_window_map;
+	struct list_head	ib_map_list;
+	spinlock_t		ib_map_lock;
 	void __iomem		*msi_mem;
 	phys_addr_t		msi_mem_phys;
 	struct pci_epf_bar	*epf_bar[PCI_STD_NUM_BARS];
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index ca7f19cc973a..2b95dbc7242a 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -604,7 +604,7 @@ int pci_epc_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
 	    (epc_features->bar[bar].fixed_size != epf_bar->size))
 		return -EINVAL;
 
-	if (!is_power_of_2(epf_bar->size))
+	if (!epf_bar->num_submap && !is_power_of_2(epf_bar->size))
 		return -EINVAL;
 
 	if ((epf_bar->barno == BAR_5 && flags & PCI_BASE_ADDRESS_MEM_TYPE_64) ||
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 48f68c4dcfa5..126647b9f01e 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -110,6 +110,25 @@ struct pci_epf_driver {
 
 #define to_pci_epf_driver(drv) container_of_const((drv), struct pci_epf_driver, driver)
 
+/**
+ * struct pci_epf_bar_submap - represents a BAR subrange for inbound mapping
+ * @phys_addr: physical address that should be mapped to the BAR subrange
+ * @size: the size of the subrange to be mapped
+ * @offset: The byte offset from the BAR base
+ * @mapped: Set to true if already mapped
+ *
+ * When @use_submap is set in struct pci_epf_bar, an EPF driver may describe
+ * multiple independent mappings within a single BAR. An EPC driver can use
+ * these descriptors to set up the required address translation (e.g. multiple
+ * inbound iATU regions) without requiring the whole BAR to be mapped at once.
+ */
+struct pci_epf_bar_submap {
+	dma_addr_t	phys_addr;
+	size_t		size;
+	size_t		offset;
+	bool		mapped;
+};
+
 /**
  * struct pci_epf_bar - represents the BAR of EPF device
  * @phys_addr: physical address that should be mapped to the BAR
@@ -119,6 +138,9 @@ struct pci_epf_driver {
  *            requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
+ * @use_submap: set true to request subrange mappings within this BAR
+ * @num_submap: number of entries in @submap
+ * @submap: array of subrange descriptors allocated by the caller
  */
 struct pci_epf_bar {
 	dma_addr_t	phys_addr;
@@ -127,6 +149,11 @@ struct pci_epf_bar {
 	size_t		mem_size;
 	enum pci_barno	barno;
 	int		flags;
+
+	/* Optional sub-range mapping */
+	bool		use_submap;
+	int		num_submap;
+	struct pci_epf_bar_submap	*submap;
 };
 
 /**
-- 
2.51.0


