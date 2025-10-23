Return-Path: <dmaengine+bounces-6960-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA94BFF8F4
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44A4D1A04F47
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA6B30101B;
	Thu, 23 Oct 2025 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Yr3TPcwY"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01323002D2;
	Thu, 23 Oct 2025 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204006; cv=fail; b=fF06O9F22vfotMiUPfCDkP2VpEqd9p5KJZPCljh0+g0lRZvk5SByekY1KUtVg1/045BuelAd6xhGbCVS27PVPOSURfyCweav+ETK3xQmVMUtmrbJLzjnEKOajJby9V4s2oRs/34DwfWs2usGGJRT9cuYBdmLDjxGbs2ezIigQ5o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204006; c=relaxed/simple;
	bh=teM/tF8b7G3BJoHvpRnJl8Ey+5rdVnJrfU02aN91LIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X3FkJgWRoWaGsGiULP7gd8/lq7+N1UPcP/Ip0NYYKn2rjbCM1YBO0yztldHkbgly5lnDVjrEBMuDRN414G6mI6tRilINqjniGRMqpT4wQhI+5W5MMVHq1J7cSkpWwDJzYJwq0hVEKDaZps33ESLpBJEPQRmSYJT1p14KwWPN0Ho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Yr3TPcwY; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTSxJ0ggQXYSnAvQ7i0Ob9MoG/AxRrQBsL79KcuxByhdWThw7joBEvzisqbUeXazmXxeQ+40NDhiaQeYO8navVJbNB9BibYZsv0EvGwRsrx14fdg/pSX66KVcdwmbSELQLs2rRKj2oecZD+ZTh7SXQHIGjubSDkPn/NZ1S8uuYDzBcjMGcrnDN5hAV/T1ft+6MHZ4S5EYkAq1klgZaMhHXonIu0kWrR+cDoCN7XtLpQyyoiDw2rtQDWcdygXnS5s2MN+37qwEMQ/so1Z3cnfHX4HwQn8cVdZGrYKaeCeeKxyDA4bhASobuEvDR4zT+smKbWIR6l6WmNYh2mTXje+XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nb3M6WBZATBeCr1pWjurr8J5kMDGBbH8naGljGihLhI=;
 b=FfByaBw0j7JSjau1tGzh419JfSY/ntKItmaFwazOE9A4D2A//OkK6VqolyNbB4JbNZCs1P/pc1JRBprNBOPcnlY9qlBoGEGZbIEOdXwqqf5jsntMF7kI9yL4TTMi8CC1BbNZCDEChci3lWICz2UbVpkkR9ySRFsQasLZM/5c/B1uiX10rvOUVEZMFeHqEJuXGre9X0HZsUt/nskc8CzCP3qhB4XC1igTN5PTn0ENYNAZT/dD8y+YKz45VDqHwQ5SfGoQywSWpmMhz4MXDvofhnxjkcMK2rFuySt8JvTTvZmbX40nUl6WCRZEETZE6oyConrelYGZxk+tq+lJ+EIeCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb3M6WBZATBeCr1pWjurr8J5kMDGBbH8naGljGihLhI=;
 b=Yr3TPcwYgxQlqEWf1eaEZ6foQCcYHPXi1Hd8ZFs8KIgUyXVVXGq6Ms+mZ4ON9nsMbFD85kj3A/eidKKI9SykGXGPTSUFjHWJjAfIGOTeeMCClnpGu2H2XTZlmcAxO9zU/WJ8lsadDVCSgl2hhO6ebbASjXWtiDOnzycaP9dmb+E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB4555.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:55 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:54 +0000
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
Subject: [RFC PATCH 25/25] Documentation: PCI: endpoint: pci-epf-vntb: Update and add mwN_offset usage
Date: Thu, 23 Oct 2025 16:19:16 +0900
Message-ID: <20251023071916.901355-26-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::20) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: a49cc4c2-e1d7-43ef-f162-08de12049007
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oZ/V24qL2xxOySGxZWMoxpprxtEj9FBh3IecgHC8/Jj7eaT1Jqr36tP4DmPk?=
 =?us-ascii?Q?hjvG+CMDSAOmeJJcDYx7WdlWnkbET3u3Zz7lOlGQ+L4Ewlq4RfvExEruvNRI?=
 =?us-ascii?Q?ry8FpRfVaKCswI6WAa+716L7oByzIQll2Wagevf8Ghbax+jqIWihQXNu/B7J?=
 =?us-ascii?Q?3Tpimyhi3J7mxcolY1nHe433zG7VJzurnvcot0lVFpYXkN4rMuOkR3/Z0Quj?=
 =?us-ascii?Q?S4q7JsA4QBFcWtKEqWRYFA4sVgQwejwwO/hFmh/Nt20ebrSUohh5kP/ev7vp?=
 =?us-ascii?Q?MD+DGJGUlO3cKkFW8noKmIwWkQzN4R17Jnlb442Kq8RCDKVjr/mQ/rX4Vr26?=
 =?us-ascii?Q?d6r0bse4y2/rXjT1SbkT4zhOJWQiRATn+vXBQ/4q03EeRBLaEWeGZCo0OvTt?=
 =?us-ascii?Q?6n0rv/LHSuNJ96lizBJPMjY5zpVSPILmRFSkbywaXjxSAYyxhUj7qvjkwRVo?=
 =?us-ascii?Q?aJfTnKNGlgKgZ0o6KwfqX8CWYteqHNVhVLueVbWmfHBBPtbHa/sG1wG3OCHN?=
 =?us-ascii?Q?k5bKaHPE8moTSDrxYTrPQiqPHg547dlIz3/oOhlKO5IKgF6eqZZ5UpQ20mEY?=
 =?us-ascii?Q?GWU9bP+/tf6r1ZCO10HV0fJJZaOmGof/ZxVkCOIncOEgUCAJmLrWVj9vqLYD?=
 =?us-ascii?Q?grxK9RbHivfhy1FsB1ZMbkRlxPPXvRCntUmHTfUUYYbgQP1wduOEHkFClWQf?=
 =?us-ascii?Q?4v/h5nocyToXwTqL+3AaiHc9j5J8hQ00kARXTvvssdl4qXuZBluW01K4zsR1?=
 =?us-ascii?Q?0YugFMpNW9HXfWiFBQahuKVjovjHw8ycL9Nz0ZSYFKPxbFM5LSPPCLZIgPtb?=
 =?us-ascii?Q?+UYLxTB5BVgSVgsFuGGUUwwsjUu+pgDzNQ0u0vN8tjO1h/EMYPQmzpCR6Dus?=
 =?us-ascii?Q?bW5sGHseWJO83xKgORaoVeApE8hpB6IOFD6mcNzhNRDlosC+2V5+i4+YByqF?=
 =?us-ascii?Q?pM5vUhrxBcCxp3Fa0DVZzfR3D5PB7hlC6uRQ4esY4tPvTZFHhZzveGET0N65?=
 =?us-ascii?Q?qBGMMLY2bgPvfcQt2Os1IQu2AvCYsSK+LwmwFJKMT/+V6/O8ZfXya6e6dXkL?=
 =?us-ascii?Q?d+ZXexMrwErke+AIqoQTS9gaKQijTzpd50LQwHTpLjJK3MVEv72qrJOqeREI?=
 =?us-ascii?Q?tUkH3vaWwyHZ+4TMQolHUMklsuwPzDI+v5oyD1eK6xWblm9HqvWrc9xlpZvk?=
 =?us-ascii?Q?ied1qu3K5YUSM3ChqCbcYLOikFPeY+7wIf6A+U2a/IAxsTUK9lJdZ386zS6I?=
 =?us-ascii?Q?M8Ttw6F0nouf6ZNd9RwHBJwFOM0QxYqcRZk4Q54nxOhkI2EyvIc0VidiQzhJ?=
 =?us-ascii?Q?R8pigrvBQmvIOOlskcslMw69WakoOAdcFU+CFHM5tHX3cEPWEAMGq64fW8t0?=
 =?us-ascii?Q?u9FequQcYxUhJbPuD6KLWqFA/N5v+odSqAB23lDny0ncUehDQ3n7BkxqsSG/?=
 =?us-ascii?Q?N77o5wsXAckH0eG/LujGRatBUiJPbifr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i6M5yJmzyKhqItA4LfXwc5WOR2IXmEHGc9lKm0EwUzPfmJj+qEzmgYpfrqZY?=
 =?us-ascii?Q?SLT5ANLwIjZPCMmR7gVZhtNFdzBdkzzcP0zrhbevXYjb0pxe8APli5JiMxjY?=
 =?us-ascii?Q?hXVxvWz//WME82t3V2Hr2CxwKAZvrw/iIyOJyFPsi1EHyogEGYQEJGFM3qGA?=
 =?us-ascii?Q?A9W1e87sNZh1pl64JU+UNUh8reL5yGkQfWqm3OjfisP7bFybO1u8Bgd1jwiJ?=
 =?us-ascii?Q?FHWAiMlY8nE53Je+8TcJjMyCt0lmmc5CN7RlRgizNue/3sf7TsTDVycDV4aP?=
 =?us-ascii?Q?7SfeHu1mK8WPrYb4LVLdkM2acJB1PymkEHbYx5E6z7mwThagz37xt/nhGFtQ?=
 =?us-ascii?Q?6xz9ZADpIUmLceP5wo4ehcSDHnNzQrik5KotDm5hVRulpdUx1+qCoTetoPDb?=
 =?us-ascii?Q?jz5DOKFT74OBFPtjNfpariRP6wgtUkDtyPylC0+37ZSqY1kGL5KUWoE56NMC?=
 =?us-ascii?Q?PJAnmFI3AxEpyQ2o/D/iJEUtrfJPGXuvjrgMh32sav4YqeJejp2esTD5oKbx?=
 =?us-ascii?Q?JnL4COFhni51D7K+ZjiOuyPcbmd3lIrrNPJiBprAonGbj6kM+prWnGPDiKl+?=
 =?us-ascii?Q?SVfjnu1cvkvVlmF/NxOw2e8gOXLocY3qo8oMcgNeHM26p2zI9DLu1UeayPda?=
 =?us-ascii?Q?NCN+qPC2I9pZljEqnHB4Zrvj4HFh/LPeGlwkWmQbrxq12PlzEDRkxMZaENG2?=
 =?us-ascii?Q?OystB8NGSA3k3O06PtwPZRcaGzNS97I+3s9lCXOfAbJWwZp/ZOMB9jgu4AUm?=
 =?us-ascii?Q?RdbBmTS5dgFS3fXkZV6im01z3idXaPXwcUCMUGme26D6ypFO4N+N1254oHkx?=
 =?us-ascii?Q?lG2GvCoLcSXZAIpX9r7YVHegtwZ4vvA2aZlZjiKHPT3Ukg27dZ9dDCcbLGXd?=
 =?us-ascii?Q?O36giHlo84d6tHbSUywYxmugD1H3lvms17mSe4ZWaWtLVYdCZgrHPwjCWIsA?=
 =?us-ascii?Q?Jq1gCdYacmOZRPPgvZcm7eYOUoNFeOJi2HErrEMw8lySK6uf6a7GQ7ftXq+R?=
 =?us-ascii?Q?3KzMITMPUlW1+joGWiXLgEkmMlFApud0nPQCiuVL1lbprRX0f5RJxHOwL5Dv?=
 =?us-ascii?Q?kdlNCU/Pr33Lgg23APjHAOzztSpTlBhYmkPkloECkBALIbbbgvc1DpeMHhoq?=
 =?us-ascii?Q?zIdS0YkgnYJHFuezFDWlq7PdXTohQOPkLGblDuA37/DOICwslNQyYmYB79ut?=
 =?us-ascii?Q?M0oh+58uIEgGAVxUwUjAWkcV3UoM2D4EFSE/G+a8QTBcQbaJYWbCMeSDyoSR?=
 =?us-ascii?Q?2+w15Jt1Gqpy4ofxDv/Jq3t2ic+vad/wAAB92wZa3MkBcE0Fdp0Hc+oEoyxs?=
 =?us-ascii?Q?ei2rySX0RNyxA+uQCTlgqluc2XrWw9nQsjAWTswsC/v+dawQ3Ji2+Ayqkjj1?=
 =?us-ascii?Q?Ei31AQOuLUd/lRMqIXBERFdS7vaMmMZdK4sFQ3oI62XoROXPrXgvVNdz1gpZ?=
 =?us-ascii?Q?XRihELHRHeYqvmjqHlZdxK7Ok+1AiHfKo1f83d7uHF+3Kdc6PJyr7LKpWO7Y?=
 =?us-ascii?Q?KxsgOA5uzjtHnkxeMbsbQNkEZFkNVUTz4OnfV4j86GrfyMjL8QhRTEZkVWXq?=
 =?us-ascii?Q?VDn9rJJ2UHhTz1mCEuj0zLhYm/19pQgAODhaBK8VPkLDbgwiZ5TFWkSggEwg?=
 =?us-ascii?Q?v8Q6AiffEa+Jd++JFEeHu0g=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a49cc4c2-e1d7-43ef-f162-08de12049007
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:53.9875
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS82Yb70vlp2OAaPuAjk8eXJGkJ1PMUSS2QekJHYmO62kBkQMkQe2Dc/a7hukYxFd35RXll0oSMtvTKp+7e0+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4555

Add a concrete example showing how to place two memory windows in the
same BAR (one for data, one for interrupts) by using 'mwN_offset' and
'mwN_bar'. This is useful when BAR resources are scarce and is aligned
with recent endpoint-side inbound mapping support.

Note that part of the `ls` delta covers missing doc update for
attributes that were introduced in the commit e7cd58d2fdf8 ("PCI:
endpoint: pci-epf-vntb: Allow BAR assignment via configfs")

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 70d3bc90893f..142cf9244cc6 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -90,8 +90,10 @@ of the function device and is populated with the following NTB specific
 attributes that can be configured by the user::
 
 	# ls functions/pci_epf_vntb/func1/pci_epf_vntb.0/
-	db_count    mw1         mw2         mw3         mw4         num_mws
-	spad_count
+	ctrl_bar  mw1_bar     mw2_offset  mw4         spad_count
+	db_bar    mw1_offset  mw3         mw4_bar     vbus_number
+	db_count  mw2         mw3_bar     mw4_offset  vntb_pid
+	mw1       mw2_bar     mw3_offset  num_mws     vntb_vid
 
 A sample configuration for NTB function is given below::
 
@@ -106,6 +108,16 @@ A sample configuration for virtual NTB driver for virtual PCI bus::
 	# echo 0x080A > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
 	# echo 0x10 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
 
+When BAR resources are tight but you still want to enable interrupts (which
+require a dedicated MW in addition to the data MW), map both MWs into a
+single BAR via 'mwN_offset' and 'mwN_bar' as shown below::
+
+	# echo 0xF0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
+	# echo 0x8000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
+	# echo 0xF0000 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
+	# echo 2 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
+	# echo 2 > functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar
+
 Binding pci-epf-ntb Device to EP Controller
 --------------------------------------------
 
-- 
2.48.1


