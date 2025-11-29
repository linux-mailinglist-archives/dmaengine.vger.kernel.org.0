Return-Path: <dmaengine+bounces-7395-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A95D2C9425C
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AECDE3A7300
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB289311C05;
	Sat, 29 Nov 2025 16:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Gf6SfG9a"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011006.outbound.protection.outlook.com [52.101.125.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9889B310764;
	Sat, 29 Nov 2025 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432276; cv=fail; b=tYogkBCv0BGLjbGoEVxOOdy+AahORf0DCFmEz9CJgUZ+FD5zfDbaWcOmjQ8KYemTQ8t2Kq1SXsp1oTY9l5CiX16OS+w2SpQO6TG5ErlNHqSF/qF5IFi1L4nzzTPdCmm4Kan+iCwFahJUIcJjJ1Q9Dk0TeBYDJqxn4ZbIf7nm1ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432276; c=relaxed/simple;
	bh=pr1fB3gT71rFk68aacz99rD9zAZF/fmO8OLC6RMRMRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FVINHNeztMW+wXycLt/U9toBs8WkFJto7jOUvMMbJ2lBQQCZKUeEqEJgtR2C/QSHC5Onx28CKXs17Q7avPWzMOOA52EvlUALABNYba5kzagLH7+L6TWiubgX+gSflZf/sNB3xJTloLR7TFotEPfoaxqnuMUY/EPu/ST8Y30Igoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Gf6SfG9a; arc=fail smtp.client-ip=52.101.125.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBSvU6xFlxVtUECK6zH/sz3agHQ07b5WswuBUV9LOI18kmkYHudUTlaaIm7G9b0FowsbOHRgtcjf74fsgWsB3G+D7REj2pWmvgMONEdR6TdE3rNR9z9YxXU5ZSrFx0PCw/hTI7CQ4y6lnMP3Kw/5RyWNdJnA3RO/OVuykMOv3AXmFPzoBMMlLXG/B6Hh9hM0nfEfChb78jrM+6F936STDBuZcoAsM/p9Lu0YsM9oaLmbwEi+FihkZloW5/hpgIXoCFPEcGuQO3jPZUbqCfi4OiBcQZs8qAcsVZlEBC6QBrn4DaPNzue9m/U9DEDEWAW9CWaDk3Xck1EXzcyx5QGv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saJKa+sCGbwpGbPaP2pGUN1WWDGqCQYoONNRfXTw1/0=;
 b=V2WZAKXu7cRz6/c6IM6X1e55QDk5mjbLtsC6m1VlBjmTN4CdiCDK78S5cMKxB49BgMRWUmu0B5GooBeuagwmxYk9HGO0zesXv4KlPBx9zNY3yrid60lPw3mH4AGEzXBZUY4hjiVEZsgaPuBcKIOQoKj6qn5bq3gi2vNtNSzWdJ8ZfZz4yKYhkSt9x04bZc9wjHKG3UcEqp4ffbstDn4HhdT5V1SHsExjT9aHb/R+DrPRc/69nUcIQosPHSEwdVhetmy5twg8a5G1+LsruKeb+Ab3oWm0nACBc6EnT26ALcRvFVxSxFmKb9MY24SuMU52C4Qs5xBf4EtsIjaAlHvDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saJKa+sCGbwpGbPaP2pGUN1WWDGqCQYoONNRfXTw1/0=;
 b=Gf6SfG9a5br1Ls8tHnUzHJmGVuUzsznQfjh/17TC/RfSXwwek8YitRKEtNM2zrTVu0jKq+Z3xnMlJaWvt7fDeVkbpFq4Oxfo1kDx47Q7doEBna02Y94tYXBaANH1t8zDBOXNw6nXeRXkZLCEOCNHftSFVfow/risWfmyUeHhUYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:28 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:28 +0000
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
Subject: [RFC PATCH v2 10/27] NTB: core: Add .get_pci_epc() to ntb_dev_ops
Date: Sun, 30 Nov 2025 01:03:48 +0900
Message-ID: <20251129160405.2568284-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0061.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::13) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: 422237bc-f226-4f67-92c3-08de2f60f973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5XKU0vgvB7I6Pune+XwNqFnmltXFK1LMfL4xK4OJatvGWT4dD0qmJhVLDZft?=
 =?us-ascii?Q?1ez4iX7HZOD3mKDulpuAle3vv7VM/U9SvJq5H751sMUfAtJym5Z/q7lUqWhJ?=
 =?us-ascii?Q?soxZbmqfe3O4O72+HpbjaBv0SLwsBcTY5gEsNdk1M2E4A03sWah098nzO2fv?=
 =?us-ascii?Q?XDZ4jQDbRTIpVExt20m5Hl4YdcZIP0bOoSaV2RKXCsXDViOyXGGY3UWKBULz?=
 =?us-ascii?Q?OqGLyC7mm2jHNAQqrTWaqv4k/OzeyqJvAl1q+8HLZYo+bsZ/teBu/nxZZvAI?=
 =?us-ascii?Q?Itp8KE3bj52O5pcrcmj2AAjuwKYz0AUqQ9HY5CU4YmBHKbm1xmD2Z4Zr697q?=
 =?us-ascii?Q?N1xQoJD/GdkIpBiQlf2ThUNwdb10cp4/9Zb6NV4LXeXtLdUAWzerAdoPZaNL?=
 =?us-ascii?Q?yNn8Gvyosyb2eyTPTPIwEGJgZZ3zKoXH6XuL2jwanPzO5YeEUH8RtwTRDevd?=
 =?us-ascii?Q?pdnfrGdNjkx1xCigQRqvTLAMjdxHXFmQEZBskAZEWpLdXNdqqNAuqzCfIS/D?=
 =?us-ascii?Q?PorPVSwo+Tx94AT+Z5ZPUUnkEezNr3otQJezl5tSUJQFFu0JNmbcx7KkiSwQ?=
 =?us-ascii?Q?C/uwv9TLxbXwzH5AASRO0vTS3Fdf1bfxIdOPS9kmoMUhdAx+9WTDgji0w9ju?=
 =?us-ascii?Q?el2pH03beGCAPtvfmO13DS5VEe/flKPY7OXVzGxnQRIWLuxzk+0Aql1TzyNg?=
 =?us-ascii?Q?yVjpwy5sR+ms7ucaUtVUP5fglZG49bmvDF9bznTODX/NIMnSMm11WnJR2jUf?=
 =?us-ascii?Q?G2qRG3juEXgXI+Cqo7OboZluLUtQO5EvO6tr67xNqnrWqb7VnAL90qKvynmi?=
 =?us-ascii?Q?fYBsYe+25I1PZgIG+9iBJeN46w1GRPfdTXSWzmkVoRiOoAaKZ0P/2Fuz6NOo?=
 =?us-ascii?Q?1uR/lsbUU/ywGuYXSgwST5KjT858Onavwb3r06PQtd4wamJJ4os9WxBVmXU8?=
 =?us-ascii?Q?oE8eceym/DWxrqZBtUTIP2YGeViSd3IniVIgLU1hITOtK1kbxdgs4cwPkAXA?=
 =?us-ascii?Q?yHhWUGz4JxrOlbkv0sfKL7AH5bwNHC+Xi0yXSLvVAn/Mffog6v7y20NisxAy?=
 =?us-ascii?Q?nkFOS7hbcWOlID5RDqVZbUMQP0kzkCSQa9xuHYJIRr55wH30fbp0gJpGQwPx?=
 =?us-ascii?Q?2C+SC8WjbieNbPgT7vvIawfkMep86FkkBDNbP837oy9aSOIQ53poHGAM0/u+?=
 =?us-ascii?Q?XhBl8IPVyCodwZvpIUjfHzvy5fDSzhbDJn/IGiEI1tBvH3DDvxFYsZz1PN5j?=
 =?us-ascii?Q?oiL/n+3Zy0o4RTN7dSKAmTCAw0aODcHJ3+9hXZ2E8d0pOrrfllPs6QCFJSFU?=
 =?us-ascii?Q?XmLz+zvg8lIchXwPvXUYN8fjMPy01H55bBJ4IH+BEbNyRzXoKHEJu16ePc+z?=
 =?us-ascii?Q?81pABd1oHX+yMbhKvCBEqYxREFWaQKF7Y8x9s5CR12tOiM7ACfSulv0fDtZF?=
 =?us-ascii?Q?Z8K+3keju6TBvdVdvB/UAINEc762yUm7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Bnns60zK9lwXFleY2XFOZbFlsv7Auvou/HkLrJdxZxdRDR6fQsHhcguebvFQ?=
 =?us-ascii?Q?Dx/Ju8s0o80tOLaENbPlW62P7ZYxZqTM9zyZoM7joX0Nr8zzDfKiJmBUViGz?=
 =?us-ascii?Q?+sniM7Do3M7mnexY0lKxkCWYl1LzuKZQ06VxDG/VCuwbVHNXQDEYw7gibigk?=
 =?us-ascii?Q?M1Bx0YOJ3TasFOKFv8DkL3dKHjLW5GR0GsxObyv0z+Y8GcKJFrqUlRVACMTf?=
 =?us-ascii?Q?bGzkl4hYGmHyHp4y+mCmWr1AN5RH39PhNtKti1gughDoD2USKngKoxc0gVbI?=
 =?us-ascii?Q?czIgONUHvgHf/G+VautMi9x1tXsrsSbxOHNgE+VmrbiN835spWlX9EaFjkS3?=
 =?us-ascii?Q?ieVNKkFW/KMmYCIdYnWmIx/urEG0g2bZjg6KrfRbCLj+kNUxfv5vypW9NhD+?=
 =?us-ascii?Q?KwZ8rxv+n0awJxgGY74ilVL2hNFnZ5Wyk8v2WsYrWvg+IB6rY66dQGGeO9yF?=
 =?us-ascii?Q?Gyrvv9DSIHN1ojd+t5HAlwNB5RtaePwhb6wVvIREHhSBGZJQj/bvQBUYpau4?=
 =?us-ascii?Q?lbWYmQkqGnBgJKoqedzTj3E0ls670u2bTOcSvTwX7syBGdRFXC11piT+NFcc?=
 =?us-ascii?Q?i7ZxiTPVRCH5ijA6rh+5BonPfEDtE4dIYJ2q4ak0+/2ePH4HOtFtaG4kMlpS?=
 =?us-ascii?Q?+ZTLipySrdeDaHgSMUJb7U4Wsxuz7yVBgnK2ACxwIuXbkvp/x/25fUvUa2Cf?=
 =?us-ascii?Q?/tHWkye8WYJKGCgVDLFAb0drrCgIXMrPob+h7z6gxsusjzUjb8/6vsYu58oX?=
 =?us-ascii?Q?G/2+fKvb95kFVsXa3IntlPoJk+dt5V+30lIAm3D6p78GhLzCdq9MS3vjhnJe?=
 =?us-ascii?Q?rf/viSnOfYTZKQxS3FDUcAKahrk7/2QNKTga/xi0Q32E3G8G0TZlHDl1PGte?=
 =?us-ascii?Q?bJttnkN9vMueeoIYssq6uY8NESM6d3oDXkS3Phl5+rCPEMbozm1dcOcpkkKz?=
 =?us-ascii?Q?NbKb3wQmRX3+mjLVbqvitxWJXkYrzJ8pH0vvPrUad0I75PjgZpEnFNufiUCT?=
 =?us-ascii?Q?g2Ue0H8Ii2ABgHl0myTnZ1r3AaKUme6jIGH0EWsVM+LOsanmDMQfOaa0YMze?=
 =?us-ascii?Q?YWF0T7aX8Z7SMx63hc6wnf0l90+dE3pYnR82OcemtTkJJ/xPS6T75Y9ujiqO?=
 =?us-ascii?Q?Ww443T2jB5lU7msO5/TWuEflwUKwwwNimwncTvL/lLT5eQKDCZwMpjWxMnlz?=
 =?us-ascii?Q?xl1UimI7JYpDPnzA/uqlJypw599l52+geHE6PFQuAKEQ+TmpRUGiQMarIQ93?=
 =?us-ascii?Q?a2tbpYUT9/WnDCiOCu/KayPBAG6/MyAWRVD5/qguyfpKoiOUcJyGFNBoUGmB?=
 =?us-ascii?Q?+rOovWC1Z7skoprFa83czEX1Lkq84xGPG9DEC3M3hyH3GJm8xWr0yCfbsqFy?=
 =?us-ascii?Q?dLdNUcDoMGR0+yKwyKssWKNx2sk26A7qhZ/Ng3Hs+bMR+8rprvBvg8Z+1Uln?=
 =?us-ascii?Q?jk0jVGXa4xR+sqUpCDvtvx3mLRZzYuvBRzw/DYyys/xJfhXWRpcK9xO4VB82?=
 =?us-ascii?Q?nGpydNZYg/KPxRWNHjdHtfQBVb9L4ZtqqpnFS2qdFSORZ3488GvE/A5DCgJm?=
 =?us-ascii?Q?2HoegtMsBmKm8rnrUQ0mJRsIfONlHTUivGNBsPgCYB6eFwUMvAIJHp5CCQeW?=
 =?us-ascii?Q?i8W0Vf5OZdDOoTmmUKtuTDY=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 422237bc-f226-4f67-92c3-08de2f60f973
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:28.2502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSBCKUYcUyQDG3ZMBoHgRfMBk1CcvGrt8ckbdDklliyc0Eoxnb1/ofOlrV9ZrDDoKXj6fJjNfD9DWGPC/NA1Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

Add an optional get_pci_epc() callback to retrieve the underlying
pci_epc device associated with the NTB implementation.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 11 +----------
 include/linux/ntb.h             | 21 +++++++++++++++++++++
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index a3ec411bfe49..d55ce6b0fad4 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -9,6 +9,7 @@
 #include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/pci-epf.h>
 #include <linux/slab.h>
 #include <linux/ntb.h>
 
@@ -49,16 +50,6 @@
 
 #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
 
-enum pci_barno {
-	NO_BAR = -1,
-	BAR_0,
-	BAR_1,
-	BAR_2,
-	BAR_3,
-	BAR_4,
-	BAR_5,
-};
-
 enum epf_ntb_bar {
 	BAR_CONFIG,
 	BAR_PEER_SPAD,
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index d7ce5d2e60d0..04dc9a4d6b85 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -64,6 +64,7 @@ struct ntb_client;
 struct ntb_dev;
 struct ntb_msi;
 struct pci_dev;
+struct pci_epc;
 
 /**
  * enum ntb_topo - NTB connection topology
@@ -256,6 +257,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
  * @msg_clear_mask:	See ntb_msg_clear_mask().
  * @msg_read:		See ntb_msg_read().
  * @peer_msg_write:	See ntb_peer_msg_write().
+ * @get_pci_epc:	See ntb_get_pci_epc().
  */
 struct ntb_dev_ops {
 	int (*port_number)(struct ntb_dev *ntb);
@@ -331,6 +333,7 @@ struct ntb_dev_ops {
 	int (*msg_clear_mask)(struct ntb_dev *ntb, u64 mask_bits);
 	u32 (*msg_read)(struct ntb_dev *ntb, int *pidx, int midx);
 	int (*peer_msg_write)(struct ntb_dev *ntb, int pidx, int midx, u32 msg);
+	struct pci_epc *(*get_pci_epc)(struct ntb_dev *ntb);
 };
 
 static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
@@ -393,6 +396,9 @@ static inline int ntb_dev_ops_is_valid(const struct ntb_dev_ops *ops)
 		/* !ops->msg_clear_mask == !ops->msg_count	&& */
 		!ops->msg_read == !ops->msg_count		&&
 		!ops->peer_msg_write == !ops->msg_count		&&
+
+		/* Miscellaneous optional callbacks */
+		/* ops->get_pci_epc			&& */
 		1;
 }
 
@@ -1567,6 +1573,21 @@ static inline int ntb_peer_msg_write(struct ntb_dev *ntb, int pidx, int midx,
 	return ntb->ops->peer_msg_write(ntb, pidx, midx, msg);
 }
 
+/**
+ * ntb_get_pci_epc() - get backing PCI endpoint controller if possible.
+ * @ntb:	NTB device context.
+ *
+ * Get the backing PCI endpoint controller representation.
+ *
+ * Return: A pointer to the pci_epc instance if available. or %NULL if not.
+ */
+static inline struct pci_epc __maybe_unused *ntb_get_pci_epc(struct ntb_dev *ntb)
+{
+	if (!ntb->ops->get_pci_epc)
+		return NULL;
+	return ntb->ops->get_pci_epc(ntb);
+}
+
 /**
  * ntb_peer_resource_idx() - get a resource index for a given peer idx
  * @ntb:	NTB device context.
-- 
2.48.1


