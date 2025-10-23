Return-Path: <dmaengine+bounces-6943-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F151BFF8BB
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E0302505FC5
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4561F2EB86F;
	Thu, 23 Oct 2025 07:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NrGXLi7h"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A752EAB82;
	Thu, 23 Oct 2025 07:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203978; cv=fail; b=If7yxIfaj66aWSA5LMjVBmrW5pxHzBhJwrNmbJSwQ9zvrIbdHohZ0lS/fVYTxwkS9CaZDD0yDONaGVGXIdxMMNz+SEz5gn8/4PJe2l4C47nviTvWqNm0PzRh4BWdknHhcuRJmFMZPunoCUfCRmfAZN9YsNZSL16Td3ASA02dA9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203978; c=relaxed/simple;
	bh=jzI8fJ10i1LU1uQ2i/bw84+GWd+L5jEanuIL4JIn4vY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LGcCjgSRbobyl9JNE5Gmp8jG987AaqDVVVAJQZ0oOgpj3jBSLyxVBhnrgj4WYT9F1Pk1l8CDgID9cz+EuHOkL1WMXfKIZ3B6XmNqnTm8scy4I09n+cBeYj2vli4kBjganRWqTbb0n7dA5ceeEKQcHQ9PPsvu85j+ZJSjxlSDpzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NrGXLi7h; arc=fail smtp.client-ip=52.101.229.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p8QiBBf/SG18J2JDcJgfEHmY7IMrgb4FCYHCh49EgZB9H6n3M2j74vYoXP7EkJZ7TtlTsQDgLwG90EYKKofqzo5dxrGy2f6EtBUim3+tZpWDEVbv/GnPJ7NNSJgUsYKK8OBD/ESJn7Numvcp0oESTbfmQJUdGRvSDDcbpG85q06kSILcq9UJb4oXejdCDTx+VBoAyn131ULduWc3Hccuz236+1SSdt+bJZNOBxRVdHFYcx3zbX+ZZg0mRa8p1z48hZRxBDJ2hU6YXgJiP6o2+G+kHJMKYQFs8D9/7RslfSiu6A7uAECqVbMByK7PbCCQWiNr6mrleKdxc1QD+kK/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhogMLlqRcvOdszyWlC0fHHhF//3NAqbsSzQqi/KjMo=;
 b=dtlZonrlmSmKlISa21N5Ebnim2qj4fYItiHgCrmbH7KQdzJxIy7miwGXhjI5Ba+/SEcDHmXUqgn9sGd1FEGy/D0Nk8JqzJvYCGjAdmWnfwi+fyyLqS1pfOLeMqWHehH3tC7ovUuL8pw2kaMValHxi0vhXNNMoZxAk3tyPkOHehh272cxMsPurb/B7jpVbgqiGqC861vX4nrjj9rvkkJdjs3krlBaOfyfUcrPl2ztUWfvOtcGA5cMtMDaW5dutBorRZWOQwGwNAoXwfuZ9975o3KFXneN2CHlvpKaxYs8HjcNhCVVioDBXwQaSyffA1BZkSJMl6MZvoiFSEsbnu44qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhogMLlqRcvOdszyWlC0fHHhF//3NAqbsSzQqi/KjMo=;
 b=NrGXLi7hJ+CL/DD9kx3LdxwtZu/Go6k6XR2w8BfNzfvsdyrwkG080YXwYRFwMdA1cNAAjWsUp9hhQJf4BOMMh/8H+G88wuqsBGz+wt3wVF8z5x4LbHRj7dNPGo0NyDko64IcNFjeQudGjsMxeQZP7/gG/PqcPcQsgKrgfkHN8DE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:29 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:29 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
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
	Frank.Li@nxp.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH 06/25] PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
Date: Thu, 23 Oct 2025 16:18:57 +0900
Message-ID: <20251023071916.901355-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0263.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:455::11) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc44656-07b0-410c-5b89-08de12048180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MJEvx1H8zlHcjuh2/Z08bV8XrBlQVKfXE03I3p5OY3KLCjknUITT6vJOlIOQ?=
 =?us-ascii?Q?6QYp0qn2eR1Qlh8tLEtBE7gvAGAXS0DMjZAc3mfnQD5w5EsDTWHUOBVB6RQh?=
 =?us-ascii?Q?OzGX6F/jaZEfpPPQfuedoK+bGUVbBO2R9N28YTzUWbTB1XWZsEso8Imce0x/?=
 =?us-ascii?Q?OZBEq1VrTywW69syv7C1ILPHA+m46LCr7tEKDdPvmkDmD9Bow6NY/0Lon23g?=
 =?us-ascii?Q?VUjgwrxwiQzuLb6rvC7M7Sx87I30M0F1h0fEzqc1OEBIG1+kK+QmuYeVMVC+?=
 =?us-ascii?Q?+tj4qU0XGS4zUlrFSaHFzD1FirTiddrknamJxt5C2JUVTkc6DlwKcm0CUNIL?=
 =?us-ascii?Q?w+4ez7RpCng2RdnsTPJwQmnVd5qTlgtlw/+CiYS1fOuBoU7EEYNIuMQlEagd?=
 =?us-ascii?Q?aB5PE9cJ2O3uxzTsBBHHvYPRLQacuEogHsrG50+AFOFBEV9DZUrirRCf7AMK?=
 =?us-ascii?Q?ordN7SqcmKaXjFw9wL6ANFqewQHUPiHQtywJ87L8ie/QyXR2xSIl35DuhgfX?=
 =?us-ascii?Q?zx27ejSTalGI4cXMjDS7AO+MVvHTbtLfknicXCdFZ5XYRzbPeS0MZ7al2xe9?=
 =?us-ascii?Q?DooLuvd0d1VQmVYXktb+kMmxLJuOZttFD1Kg2c87391+Lmgokllt4U/7SeF/?=
 =?us-ascii?Q?tSGN0MboI2WCASFVhHKXN0YmsV+zbBCxOu5TwDcVLyOGJgXOtdMpxZntsQyu?=
 =?us-ascii?Q?B4YBgv5VjJbXsuPiHItB/gjn1mdO7Xhwtv3hUsxvlw12JuRA/2v+g5zBRV0Z?=
 =?us-ascii?Q?TLjTR19ffBykY/KXjdkVi6wN5j9Cxe4zuP0ZRE/yN4fq56LiMN2miNNJhUdG?=
 =?us-ascii?Q?Tkwv9EQMNSmriEDP57C1icaxgz5C+pDccAMGtBkwPUMJoJxTJVRFYV15ueoF?=
 =?us-ascii?Q?DeP2bnbksuOUQhXaQ6fHWIZWKtWIDtLSBF6Ng4Byex5OVW1vELY5BHmOlevy?=
 =?us-ascii?Q?XrMrbvsUbt7PtOqc8ccDw8R4NhpkBebyfsMWe3/NVGaO1Ga56Pb7U77l4rpP?=
 =?us-ascii?Q?FJQeD8xNPSF/QlLpjBQ2n5bcmjnk9oLyb1hskRugUdBwpYjEHiUyT2uuN21A?=
 =?us-ascii?Q?xEoivFUstMoD5qi2/MmULnJaYAvkSjiSeNXj2qMsuVov9zmW1B3xYaK+n6+h?=
 =?us-ascii?Q?yw/EpY2m1b/khuJKKILZB+fY65x07hKNHcXaNwAYueorctAQL17VR5HmH4Uq?=
 =?us-ascii?Q?FSLcAOrYKGUhYYB/qujPvP5Z9ONz/PG9UWkaYv2RN+VOAeqicDGi5H3sjBCp?=
 =?us-ascii?Q?kh+pn3M5efaLQgyuWMCB4UnbfpGKaFKlO5N6MGFEhivhXWGrP75WYg3gbHe0?=
 =?us-ascii?Q?J7fMy47zSXjbRgquRv5uIVLa2cguGiBzioaTw+MCTWrB0rQurIumaziIX0xq?=
 =?us-ascii?Q?jBpL8uKCfSArB9BpfUwtZdPtGOh9KC+s2WEkH/xgrLMxiaxTox7PDA37APin?=
 =?us-ascii?Q?ocBEuS5kQymhUYUnMikzqFV3WnQ5N6Is?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QzLwK2Gwlef8Tc/f34fthU7JS7G8s784Mj9IBCGrW4eF8igIx5zKJS6wjw7B?=
 =?us-ascii?Q?Y2U8itK6xxytBNorsqIgLU3e5O+qYnR7uHtL2LmObfGUJbUBSpiU7izBF8OZ?=
 =?us-ascii?Q?pvikl+70ho96Fm+bU0gy2b3wrmkuvu1xo7yugNZRExQuOJ0YdtZDnSbTUUET?=
 =?us-ascii?Q?j5XvN9B9uHmohScW/h4k0Wyp8TylDZeJeblyOi7QDSiSxTK7ytQXUcgSDgIr?=
 =?us-ascii?Q?cXywVD8HvFbYw205/f1F8UTDGEA3x+p/0ak3e6J/wmwLNqwTC4NgjRX2btt+?=
 =?us-ascii?Q?XpOxaEB/Qqv42qxO0tjfevp5LwYfRThuWgzjJUWLYyG1DThaEH+Wo6HZ+LCy?=
 =?us-ascii?Q?QSlc+7tv4LmogyvzkX2F1nS+SfGYpqGCDH8PWrZirnxCAGdduAo1ikfQ2sgU?=
 =?us-ascii?Q?LdFSqCBzP40GW3yZeGzw98BPW2RGJv8KymBBQE2p5BVn8cqz9nye0miefrqi?=
 =?us-ascii?Q?LejrHALf6X/ZZ+VoxaVF4e8gtUEoqOT52LzgxUeFi1+4KzXgSSoWWa5W8iBT?=
 =?us-ascii?Q?KvgipTZ5/fEK8Ff35N32pTrG6mM8QvDWgkSE2aNrfJPOW7GO1bzlGoaIMJnP?=
 =?us-ascii?Q?fcaY8fmqPLqpw7DFPWQUO85P1S1nXlKHuxmpDMZJB8TTJ6QWOmRm58boF1L7?=
 =?us-ascii?Q?fK8M2k+a39wtdVCIRgNKET+1gk5qdBR/LYwLt0YZaAzgU9QlTBbkVPITBL86?=
 =?us-ascii?Q?rjjDe05vn0F/M27VoRVs2Wbjt9wPionQnz7Skx4scxVkIrp7t8oaiJ2Ti9ZB?=
 =?us-ascii?Q?mor52PkMKjoEG5BhMDrxYkGcuu/Gs/yia3la54F1UTpOrRZ4D5hWoE/UJXW9?=
 =?us-ascii?Q?XZHHP9oeA8tguHnnAJ4+Tvd9yHPNmuqX1IPy43AVjCb9zgN0ao/7D7M37iUW?=
 =?us-ascii?Q?x3JoP/lGk1m9ouyp+qzuED83iBS/SRyKt/oMifgHxEUdRO+Xh9mOdAfQpagZ?=
 =?us-ascii?Q?zd1+4xLkMU+60l/hPw60sudfDQe/HDfgJsuvzP7k6DCsxyWKCCjkGGBSlpzZ?=
 =?us-ascii?Q?nuo3eqfXUF8aqqyrix4iCEf963Y8/TspJRvXRYaQFJ7jTmEoKKpbkP2AtD2H?=
 =?us-ascii?Q?wXcI01SaeyRUSrzwSlZmz66AurqeGyFLYHudWlIIFnYZJ81NXX9HMFBpQGs0?=
 =?us-ascii?Q?Dml5LiY80VuR6pcbk/FsbKytrw6Ygdcu/qKTcJGm5TpODScNXu2bEfoKrWmx?=
 =?us-ascii?Q?F83ANmBRCPE6hkE9YgdNWgdGMXeJ0Ty98iCNje51gKeVg27IiYLHm4pZBb3X?=
 =?us-ascii?Q?EYORGsBhK4mz76PUL2+7r5AWwD0xaVSBA820DayI0KUqmbSX5BH5xz8MItwT?=
 =?us-ascii?Q?u7UT/Zc1eEb+UFPXijT26tSsjQZlfgPHmJOKROdnLC+H1WuVNh6t/AiODerI?=
 =?us-ascii?Q?qf7hTpTtvC0BhYsXeFgSaUot7TdyntuwwtJQlTAWBDS+zt/6xq+WYrnRUD3O?=
 =?us-ascii?Q?GtYD77qa9zIkNQcVInPFlELw4QofgcTeIKLSq8WCDswvLfOSiK9Ri1fJYXjU?=
 =?us-ascii?Q?rI4o1VhkD5tGHGnXkyOvviTZn3hAGdrCmxy5FCIwttU9yOC9vl8qRHY6KojV?=
 =?us-ascii?Q?e+k/xyQhwP7zGc9f5G61VLcHVGuxr9SZPFfITxHEHIuP+0IMc0ISMZImcL73?=
 =?us-ascii?Q?gIR66XBo2Hm70+qmJpJ1Roc=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc44656-07b0-410c-5b89-08de12048180
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:29.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FMDCtQDe163t4lKmtVWxV0HSharcTONxAvCCUU4EMzO32lQ8o8vYWeLFs0Q+GKDD5GWFtOYtvNH9igVfVzvZgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

Switch MW setup to use pci_epc_map_inbound() when supported. This allows
mapping portions of a BAR rather than the entire region, supporting
partial BAR usage on capable controllers.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 23 +++++++++++++++----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 6953abb2987d..5b3aa1abeb70 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -609,10 +609,16 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 				PCI_BASE_ADDRESS_MEM_TYPE_64 :
 				PCI_BASE_ADDRESS_MEM_TYPE_32;
 
-		ret = pci_epc_set_bar(ntb->epf->epc,
-				      ntb->epf->func_no,
-				      ntb->epf->vfunc_no,
-				      &ntb->epf->bar[barno]);
+		if (ntb->epf->epc->ops->map_inbound)
+			ret = pci_epc_map_inbound(ntb->epf->epc,
+						  ntb->epf->func_no,
+						  ntb->epf->vfunc_no,
+						  &ntb->epf->bar[barno], 0);
+		else
+			ret = pci_epc_set_bar(ntb->epf->epc,
+					      ntb->epf->func_no,
+					      ntb->epf->vfunc_no,
+					      &ntb->epf->bar[barno]);
 		if (ret) {
 			dev_err(dev, "MW set failed\n");
 			goto err_set_bar;
@@ -1268,17 +1274,24 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	struct epf_ntb *ntb = ntb_ndev(ndev);
 	struct pci_epf_bar *epf_bar;
 	enum pci_barno barno;
+	struct pci_epc *epc;
 	int ret;
 	struct device *dev;
 
+	epc = ntb->epf->epc;
 	dev = &ntb->ntb.dev;
 	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
+
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;
 	epf_bar->size = size;
 
-	ret = pci_epc_set_bar(ntb->epf->epc, 0, 0, epf_bar);
+	if (epc->ops->map_inbound)
+		ret = pci_epc_map_inbound(epc, 0, 0, epf_bar, 0);
+	else
+		ret = pci_epc_set_bar(epc, 0, 0, epf_bar);
+
 	if (ret) {
 		dev_err(dev, "failure set mw trans\n");
 		return ret;
-- 
2.48.1


