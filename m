Return-Path: <dmaengine+bounces-7385-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9FCC941E1
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107023A6308
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5AC0217F24;
	Sat, 29 Nov 2025 16:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GhwhHw6k"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA29413A3ED;
	Sat, 29 Nov 2025 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432264; cv=fail; b=A0mlX667KNeQpcMGSR58osheYIEkuDCdvc5uxctI7AUQuhLw3pQepEkTujGJ0CFWCe80Ia/jJVshqV8HHjxIC1TcVWEqB0jW2dNiVVKkvotLcyJSMBQMRr9PdAr9oGQci6REu0qaQNtY7Y5hA3taZmhFzJAwet42agdkJSjZZyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432264; c=relaxed/simple;
	bh=XwZ5dNQEzGgAvF2F1laVedJASF7uPmJBpch7txjKQr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NJUlxg5HNfOzoCupfbLttbC8XRwfDdtNd0uL7wBvIKj7fN06aS7ZNnAeQVZWxnM6DNwMq2IwO7oulNJunOaP47B6pmu31nzuP12TYoQ9vb4WzHOE1fR7FQ9zo1xwCCD/WU7UkdlExGV6Izvu/9b9Oq+sJAC/HFjWn4PbpAhLgQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GhwhHw6k; arc=fail smtp.client-ip=40.107.74.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ByNOQMZToRycKD3wxbq8tnpAtGEyP1EwI/tUeTIhxhRQEij5zBtEUs6po274O1px9e7htTWUiScItLQjVVVcz0Lm/uykHR66T7kXOFxkMRwPbAuRjE/yO7KUHcGYCL/GpH91bPFJ67ogdWVFDFm5TUW23vYba1ttrFaX7kC4r3htZ01XRIzD39a9E+aHCViLSYuJozoDcYfkIQY+nWkrHsMA/j94sZPyOQKCtDNoc+KSwv57n8qlJ7Qk+MCnsj/8xXFLsKiDuQ/NbzVgNUm3eFc1GHgKItxdy0WYhK0g5N9sSg/f+UWoI8swbcf3vNgXZFYu1J6+ELJmjtMj0P7lhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMkJW3sD2981ORC7jVqSKpC+kcwWa/jtaLJ0a6QE+Dg=;
 b=LBUOFXXZTMx2m+7aiq9dyr/hLTiLhJvnhoXQ5b+Y59QMpXvlL2+EAchXf6fTvgsFolY/G9MmBvHn7IDnxbOB+3TtVQ08oUsPNVS0/WaNMrlygsgMYu+bYA81AUD+VSX8VIVHOmudietG7Q9LaffXeGJX7qOgkIiN/c6XbbSkJ0NPJEfTeLq14Za+aZLZiJ+VfHbvnQ2x3skaobDqHC+ApU4TLcdtsmQyzJZK0/FTGMDw27HKECJU1zbicRysbZ2rHuBDvu7+uFJJgiu4GGtUOBak1N+PL9VHXEzsXWs8hEw5yCVjBg4l+DYOfzSXpGxqidbN1QziM2Bejy8bjOgAwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMkJW3sD2981ORC7jVqSKpC+kcwWa/jtaLJ0a6QE+Dg=;
 b=GhwhHw6kiwD8mefMXhVFWyX72c66P0+EcxypDk26UHSuVEPWcWcqLqA47+A9jZaGXTQr+S8jhm9Pk8kYDiId9RGUTpwG0AvMO6uNi1S9oKa6iSz9LoBc7+d4OYOA7wd+3LYoVjrFYg/a+KrVV7gTygLUSKkRDzeu8lXHiQfo3SM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:20 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:19 +0000
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
Subject: [RFC PATCH v2 01/27] PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[] access
Date: Sun, 30 Nov 2025 01:03:39 +0900
Message-ID: <20251129160405.2568284-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0250.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::14) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: b143b74e-1d42-4941-be8f-08de2f60f423
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?efr4X7sdSXuEPDBRBmeDV1XnF57UQy6pjKNhsvxvXqP1v8yccmOw9r98dge0?=
 =?us-ascii?Q?COOcRj7SrKLs9tx5j2a4Fm6+jWl92zXPzUQokH71Y6tREvOKN52NOdlMarhl?=
 =?us-ascii?Q?Ennb/2lws0WIw2yO+pIfWYbD8PpY/stD32TZef3Hj0kwanrP5eK35ya3MXxm?=
 =?us-ascii?Q?NfSp2qzYmNyUeZioEvMyifm7IrQoia7Qkj6avY2lEngjwgeri6cSRnMVixpr?=
 =?us-ascii?Q?hRylzcn++kIWfJxpoQNpNC4vVgu2ZEi1XWVnkTxHhgehHbFfwZgGu4in8uL8?=
 =?us-ascii?Q?H/LXh8sLfQwtVJQiLgwTBeqh4qtoIhXqXVSD0KWPFkuOMibqngyRZAg4QbPA?=
 =?us-ascii?Q?9Qh6A8Y93AIP+gwGRgYwykdr5Xc3LmhVHaOntRClYB7YG47/tANQfRdbSoNX?=
 =?us-ascii?Q?ojrJ7fa4Pw12bK1aithY7qmiva96latovBMYX+9mS6DiTEi/XXUfVPMZ78Iy?=
 =?us-ascii?Q?1P/NtMdRUNfn+zulhw73AhMct8bGFGM8gtCII4013edNP8QgFrbkzLTHobd2?=
 =?us-ascii?Q?tb3g1vaa1vO5BoCzHidOQ/eg/UCzvZZ7x2FvWmWfF2lQKSKvOAji5DLUt4yy?=
 =?us-ascii?Q?pPYi1Q05BXGRdLy58iALgPLrSYEmONOmyAkcybctLhSz9gY9GY4MYLBNjjbK?=
 =?us-ascii?Q?cWDQ8hfGYOoG4fxHfEjc9rHJiEtL8ZdciTQSosB7GOhV3I4mNYdsjm/l8CxX?=
 =?us-ascii?Q?ZYS3B4/fke5ainOMXNEh4+J+Su4UVnBCflLrFOEZP3DdfvUILK68Ni7bR+jf?=
 =?us-ascii?Q?s8E1kKEZLjblz3a83BKHCV4dNU+rLiA0nYizVToEqvMv/6WfxMNx2SlO4DF1?=
 =?us-ascii?Q?R8jk+XVxeSzt/iY4hCmA7qMfgdX0zmz7ia1YY8AgZV0c+oGGcRTboQJp30gV?=
 =?us-ascii?Q?Olo58/1g+XePEXIB1JKdcoX4TCmI6Zsm0hHQXcFJ5OdxNL/6hUBUeYGihkLu?=
 =?us-ascii?Q?TQ4zFih7IJMHxdqq5KjkTeWEoPYqA8lUhFC16fFR7PneVgS0RAG1pTdxKWHX?=
 =?us-ascii?Q?aFmnCZOXrC8n3ETbUOf+h1OxhNTyQJqMQquayFwtkdDg+cBHU1kqMKnHUP04?=
 =?us-ascii?Q?Tl6YXW74pSaDl0PSF8PNMOFrL2EIeTJnD92PCllDPkIkpx74dsdmOWrrytOA?=
 =?us-ascii?Q?oOVnvgjjionIw2JG2n4Yh/9kSR0F16JF8n3TR2zn8CaY3Vr+ik4AULEIvwPG?=
 =?us-ascii?Q?8TTcfJOcXXmdfXZ+t4UkRjMxXMfDYVuTz87yOxrjhxFzKaclqfIERgJDMLJa?=
 =?us-ascii?Q?t0rlb+/3AYsXKreWKKvub2ZH6YinMwIc4W8gtCvOCoFHCsPLIaW0V+rUzZsE?=
 =?us-ascii?Q?zUoxNbVhAfHVajJGjMVvUhjvVsF70zL/ZdfXJYNV4OMRl/sdrHHJ+BfIiDYP?=
 =?us-ascii?Q?cholghbe55IAVBcMpF4KUuMgGg2RzxSa9cjt6ioqvrB0lPyIO5sGx1D130Mj?=
 =?us-ascii?Q?z4bcrx4i7JE6yrMP536/GZNrUjFTIzC7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XeQ/xCpHRepSU1xGGIDguIonIHTQRsaQVrpBO9H3ooPZJhXr5U/0GGq9ZXRr?=
 =?us-ascii?Q?FFdlSn71t0hA8R8CVAqI+7Lbq8AanaEJyNdfGC2ZEkwpyAU4CZMJ9xcPbaxx?=
 =?us-ascii?Q?zx7W//aeQMo/0hIE9Pb5HAlujhOqVCyBDT8YVk4O5EVBF1XDkLm+UbLLiv52?=
 =?us-ascii?Q?EMaG7g6cvBrZS8hcawkJBggllVQ3S0uYYuNdwzOg7jE+7M78oeO/mqlX0dwb?=
 =?us-ascii?Q?NkeUx3CvI3k/5XbWNvvAUUiQj6xcAgWjEM2iHpXg2jWeqwl63ecIBsmHR8tc?=
 =?us-ascii?Q?iRbPf2470SGn4c2zjPmTqbsnK7zbKEQw1YKByhsF7a+4wYW/7D1sr4mdnctY?=
 =?us-ascii?Q?l+vqIrEiZO8VffkyO5SBDuJt9EDrl7BR8I5E2TERZNniWk/Zy82R6/R3uffv?=
 =?us-ascii?Q?tdFSyaIpAosZxYc2Y04ozh8x0lMyXpITE/x94XlytxLOuAiJXV43RAvjQDSZ?=
 =?us-ascii?Q?0UZ8d2qRFnmtGFOIXqki1wTXUNlfsbrAePWAAkkuyv3OGQ6MXRAJEAfBSDHm?=
 =?us-ascii?Q?5Gj8h8THpD8Q9Kiw2jJ//84/Akc4DQnwGjTd2BZUkVUtFfNWYhWaOci85XEN?=
 =?us-ascii?Q?hKfl7jEUARMchpyoiZDdkLAaYLo9qiOfDodGzT4qwy4FH4yvKD0jV4NIL5fa?=
 =?us-ascii?Q?eqOrBSFrJhD/EOhvLpet1jrlMU1uv/22FeppAC360wbFG2mRVXQrMjzQxOZI?=
 =?us-ascii?Q?KQIdvwSaZC/cNFuXcofn0z3Y4cauFsDr4Hoq+yyuYn21VgA5JPaJugEYy8a8?=
 =?us-ascii?Q?Oxg3CEDbk8G3piXjMMGEndT+MSbCOicMxLkFvXfNUgfdU87ftw+HLL5qj7nC?=
 =?us-ascii?Q?5v62pKwONvuZoPlme4LM9Usc7bS8g1d/WwLNFrjUOQ3IPXXgMilc3/tOTrIf?=
 =?us-ascii?Q?EMu2K0hZXfRHXtJd/oArlxnv/fiHNReFDRtwq9LedWvDIo7fMxpfFn/xxuQ/?=
 =?us-ascii?Q?9IdHwEiUQuEeVa0u1nEzBA1Af7mhqxnIZS++T7C3x+lcIc/YD1TY8qsBDlnP?=
 =?us-ascii?Q?bRalIXiIOqawBu8Rs9RPyr6BjTVyqfRpuoJOde/PvyFAlEejZ0wxVkwNSn8v?=
 =?us-ascii?Q?Kf/FyRvcY5q3G1u9uD+R+046DnEOF8CTokwUK1joWjz0SCm/BGC64oQYYFBU?=
 =?us-ascii?Q?lDQE3DYN9YpI/oWaI28jQokjGc+ZRq82XYXE5CPNtrmt4thcjV8Lg7jcLCtP?=
 =?us-ascii?Q?czwM6fMtfjnXIYxqvWKPLltKyku+pS90yk0WA3J6KQD1vLN8EdnX3zOLac/y?=
 =?us-ascii?Q?Kd8FnOmNiNwotfLHEgOH7CvSbUThldxfePOgOBxQR9iK65bCJsaheAoraGlz?=
 =?us-ascii?Q?xR/9bsk5lqP+tCXjxtazfXsvJYmSmnnJjCYXKm54YslLB9a21IBOw/KGZZy1?=
 =?us-ascii?Q?jZ4BNX7XlGs+zQnKU6hYJEejPMTqQGc+ZGIhT83GdOruOeQpsIoDX5DsVJ1+?=
 =?us-ascii?Q?x7JxbOf+Qrt4BPfNiPzUzBltb/yprQY7YXayz4qfpXRTMfx1UY2WXbI9FR4o?=
 =?us-ascii?Q?b7mO79uWCP2xabtYJVicga0n4jKznY0BDza8PYIEpb5a6evVUvbQAHo7O8Cx?=
 =?us-ascii?Q?euppUfhpo2I0dqvs6tWMWheu2qoGFasnT66S4jZclKQ94tzHOUfgk84S98KT?=
 =?us-ascii?Q?UonlO6/N69bcR0RuVeZyp4I=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b143b74e-1d42-4941-be8f-08de2f60f423
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:19.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SuiwFksHRkCsClYW4mfOpDcaLrrY0Mi9MjTucMljjv+so5G7Un3CTfOB00a+nYzEp57KlAVaea4nv3h6rC0K0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

Follow common kernel idioms for indices derived from configfs attributes
and suppress Smatch warnings:

  epf_ntb_mw1_show() warn: potential spectre issue 'ntb->mws_size' [r]
  epf_ntb_mw1_store() warn: potential spectre issue 'ntb->mws_size' [w]

Also fix the error message for out-of-range MW indices.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 3ecc5059f92b..6c4c78915970 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -995,17 +995,18 @@ static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 	struct device *dev = &ntb->epf->dev;				\
-	int win_no;							\
+	int win_no, idx;						\
 									\
 	if (sscanf(#_name, "mw%d", &win_no) != 1)			\
 		return -EINVAL;						\
 									\
 	if (win_no <= 0 || win_no > ntb->num_mws) {			\
-		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
 		return -EINVAL;						\
 	}								\
-									\
-	return sprintf(page, "%lld\n", ntb->mws_size[win_no - 1]);	\
+	idx = array_index_nospec(win_no - 1, ntb->num_mws);		\
+	return sprintf(page, "%lld\n", ntb->mws_size[idx]);		\
 }
 
 #define EPF_NTB_MW_W(_name)						\
@@ -1015,7 +1016,7 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	struct config_group *group = to_config_group(item);		\
 	struct epf_ntb *ntb = to_epf_ntb(group);			\
 	struct device *dev = &ntb->epf->dev;				\
-	int win_no;							\
+	int win_no, idx;						\
 	u64 val;							\
 	int ret;							\
 									\
@@ -1027,11 +1028,13 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 		return -EINVAL;						\
 									\
 	if (win_no <= 0 || win_no > ntb->num_mws) {			\
-		dev_err(dev, "Invalid num_nws: %d value\n", ntb->num_mws); \
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
 		return -EINVAL;						\
 	}								\
 									\
-	ntb->mws_size[win_no - 1] = val;				\
+	idx = array_index_nospec(win_no - 1, ntb->num_mws);		\
+	ntb->mws_size[idx] = val;					\
 									\
 	return len;							\
 }
-- 
2.48.1


