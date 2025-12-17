Return-Path: <dmaengine+bounces-7777-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A42CC8848
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5415530AAADC
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D588364E9D;
	Wed, 17 Dec 2025 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="dwCQeaGR"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010020.outbound.protection.outlook.com [52.101.228.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40691361DAD;
	Wed, 17 Dec 2025 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984672; cv=fail; b=bqKahxvMH5zqqWIAv/wyOwtvha3+YG/AJIvevgch2oJHdsKHIFXXix24v9GiFc9MAQeAdf+uqkQkq6gDUujIXePsXnEJCzofl287HwGGZjwOjS3EIdoocFpdNtfsqfhMdC53cCD4TgyIthduVhqxDApj6In++mXxiK4lGmYAUVU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984672; c=relaxed/simple;
	bh=fOSJLrLrFLoKv0qHk+W+c7m9DC4dwJUYznyFzyvl1sU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nJdMBb6dslm5taLpoB8BSOhK25kVnwSYLzPhnS4UrMAayShtr1/ePcRSDpGAyfXLQ6x5BS/0lr3A1t5I1E0XzEkeA7DSjhiweu93HgeXwP3uU6VLeQSOmGgSf0eB6twU/35qIlCr3xGX6Fu1FqOVFPfN6zHIe6K9/20DeeFnus8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=dwCQeaGR; arc=fail smtp.client-ip=52.101.228.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NAFviUgJ/eYPP00FdjelQ6molxSmQTtVrxnMQ0y0cCYy7JIssqUUG2UQdz/BTrJE19BxpP2h8k+gTTOLb+wZLl0RX/0nR0UYkqM/Vij59AaA6zC1BzdR6jz2/tJhIV42aMB5C5+ndvokfWlvspzNTfI4ADrb80LtFL/MOwtSJO6dpeDAETY4Yd3IydwCqX7mZ/GuDc7NANOLc7vTsXzkBIVvUhmT7K1P6MHLBnF4X1ZbdCQdOrUqF1AsXYNBvr+tCzMCP3HVzDaFDL4jR+f+DetIlTlAm9Y1QLpGBr5bDqvbYQwH6qYSWZoU+vyr/bTWz5RGNdxXjG8LpQU6UFTtLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d06MQL3alOxYyQ0pwMZdFFY6ArVfMDxTphVx+kcblwo=;
 b=xscci4InYLdJQrmUZHL37StNEZZnHp+OLU4mBwMOMl0w/tjiuhuRR8vWWieFxnxq5n0fvrhGzDBY9OlNAlBs/c9oroRzkRy4Za1GYPIJF1gCRMYNJOIaEy/UQ41bQXsgkexwRtTurs2JfLoyDtc4fIWx/VcFPQv9Bo+k//K+C6a+wTkEgfsTLZc3T03fdvxCJWBvuQK3fvJJgP4iC/vSZUWTAbDybmED+zeJmLmu2waN5nRkw7nYvU+7ZBBJvUGG0CcrzNV4lmX1lxtP9wEfYj4Mgv7UNvmJycCaqmufBBIx/Ud35Tz4G5ghHUI+9z85uyddz7LikbzJnxVf5awyPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d06MQL3alOxYyQ0pwMZdFFY6ArVfMDxTphVx+kcblwo=;
 b=dwCQeaGRhcQPG0WBOm6ufnjbXhhBqP8NfFzCr4sYY5Edz2RLx/RlZM3DCXbC6ukktcehEdcCG1sbrmPQNbbKrYl2g+rRPqabx1xsm93Asm1JT+mLm9Fax0sNfEZx8Rc2kNbMoOExy53BDQ3OXHqgyLgA8Q8gddmnyA01u62cqL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:39 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:39 +0000
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
Subject: [RFC PATCH v3 28/35] ntb_netdev: Multi-queue support
Date: Thu, 18 Dec 2025 00:16:02 +0900
Message-ID: <20251217151609.3162665-29-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0106.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::17) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c5e57e-be89-4e7f-4e21-08de3d7f46d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4yLkxDCH/B/xkFCekL5/KbJSw76bENkIpzfPTySCCZB4NEszX9t83ZHNzOmI?=
 =?us-ascii?Q?9UdO3wz/gt7MtNR0zzSmjzVB+Oj7lysUEC1odb41xdFza9jd7t7OItMYzBp1?=
 =?us-ascii?Q?etCYnzdfkH4vG4kmnfago33T8uxHCkRPeR/6nyh7PgKB2QfKYMSxKOBBzudh?=
 =?us-ascii?Q?Z6Keu7ZDWxXL0X0hERZ8KFk2czEux0UtL2tgbW5GYKax0CwCGnjQ/Z3x6gts?=
 =?us-ascii?Q?wE63QKgtczGQTj0IC1Edl4SO1RIbVNatzvabjtGaAdPieFpOwjZHb5h3hOjS?=
 =?us-ascii?Q?xC18qAogu4+hwz3K0d7/eED7lb4q4jSua3vbCzWfdZaOCwLtrYURNS0kyePx?=
 =?us-ascii?Q?V/qjQ/uR5W9vu4C+8/Mxd3IEPUPHMpZE1DPrxj5iX19WSIWLFl62k+re1fbz?=
 =?us-ascii?Q?9RYuMPzaYAHAxZS1LJurPvBn06TxqwUg8mVFEQumX+WwnKl9ATHrsMe8ZhPu?=
 =?us-ascii?Q?94X8TQ8XaNFmy+G+s6CqV3dmJ+Rr0U0DdGv9MbYdjlaiGi+lx8o0ImPWJSPn?=
 =?us-ascii?Q?YdQ5LcamHwq03v9w5AleQ9BgGL6QcO6/fTOY29/PODEOaU2zp98U74E07hoA?=
 =?us-ascii?Q?+uBf2kWE+ay7ItdkZRMdHGGzQ5amfWLTV/1pDSrkqkeXY7Vt/EVijNvT4mQi?=
 =?us-ascii?Q?ycyYbBWwt3UfkSXJ4g9a1y0AgLjU2RXHFsbzi22NdE9TVX3iANgippEILEgQ?=
 =?us-ascii?Q?euMIQHS3YVThEni6YHfE+lxZAUODSHg1PEJW10zc7RZCyMNPR9YAw8zTJ74R?=
 =?us-ascii?Q?GB1Iw0IP1KIGVj8rXY03qFk9h6Y271P0+4pRP61qYiz2XoNmJjbccaK/CF9/?=
 =?us-ascii?Q?0uGKQaYWuKm1gsUqgYpXlxQ9na1nTrm95N7vAah3mUAc2hUkJoMI3RDijwt7?=
 =?us-ascii?Q?6264TghOMXixzaXXKAYaUe2p1WGQmvZaGCIYM8W6a+ZfN/Y3OTkmpTvmJ/rQ?=
 =?us-ascii?Q?VcbRRXMytWrfb9JC4HDBUyPV7XzJDpMtpARWowkP8Eu6JQfSBEPIRLxrpYeo?=
 =?us-ascii?Q?/PI72UKTU/cgdJsymAyOqYwUmq0LO6RZroxQDHlV0ffz7OvxGTY2VYPIRODx?=
 =?us-ascii?Q?8K4NyJ7Npu3YbtVJcloTUv7PwPlreS6X5GzzN9K9tgOCKj1epegDloAiKlgz?=
 =?us-ascii?Q?SAtuHa3JJ6cViXmlASgHRj9F9/hRWkQ1Tg4nl01QaqZ6+d0vnzs4+TOECYcS?=
 =?us-ascii?Q?fgr6VLiFxkoXZGkqgAD0VzAMzfWS6T70C1tlBXR26nRXlTR1EN5sP7OnDgnK?=
 =?us-ascii?Q?6EXb4I6tw+1yfoRZ9bt6f1avBLkjEGzvNKVjVz+J6Al1uIBiQMpJiMiA65IS?=
 =?us-ascii?Q?TtrKjWwbhOPOR8xao1zmM3n9hP4qSMacRvXyN/Ghsh7BmkSWmCU+QqDwd1NK?=
 =?us-ascii?Q?u8XocNjIB6ZC2oGg9Ua2ec12spAUGapZIL6qo+NSLVjoGiEQc9sTZP6/P/n5?=
 =?us-ascii?Q?MWgcgcaryNSeJ0MY1rESkqwyhbZ98YVZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RhEjU/OxcZtLuYJqNF0xsB7I/ypfSQMhebXCpyfzWXA/ElsFl4lIxAdIrOXn?=
 =?us-ascii?Q?U1IOfZM8+B0quMrdDeqx0qCdSbmEpDMiWXUnoq2YXx/RSLlgtxSjJe1C/bR6?=
 =?us-ascii?Q?QgR4ZnF3hM7pQSX9PwA+9N0NBZw27vRZATTwOM2fIjQX818cJt4/STUfjlT5?=
 =?us-ascii?Q?fa9G8GUa9XxBOkxJcU+yS7CoF8b/NQSESByLnL09r1vqDHkznP6C1G6eY0Pv?=
 =?us-ascii?Q?SP+NjMXFH1g7sHF1GA0fhPN4uMp2Bj8n9yirFhWv8FrGfDDCyCgTnmkKxl30?=
 =?us-ascii?Q?hZOl4vaOKfucsw7/boC4KUOX7GXCB0NxvYnW9gyIDjPyiDlL4+/R+qKQcBkS?=
 =?us-ascii?Q?B4MrDU1VRAcKg3wVtC8C9vDBrG70jeCHfA8MXMoq6F1OUBUTF56wOpR8/9yp?=
 =?us-ascii?Q?BIlbbuxD3+Iz0S6duE6YmTzeqInuHbbutWlFfzYKhN8Xxfx6xu8B6Y1MqL0u?=
 =?us-ascii?Q?y44ZFPx38O07NsJ6M6EYDR6jIF3gWG1dbl4/7urRQpcLs4ZqEsS1hqmn6YDl?=
 =?us-ascii?Q?MOhHA1emja+N0/cULiIahujqvpn8IT26ScGpPgZo02MxsBbsXaTG5Eh7hqiV?=
 =?us-ascii?Q?2EULgWeCxec6cw8O6SR9TLk1eb3cR3sXQRMM+cpZ0t2ud25sqkMltGeRATGm?=
 =?us-ascii?Q?5ErGHdDhVE5e6Po9ikQIBP36YmytAlvN5adc6hrU1Ul+lv7D+marM/TyPlIl?=
 =?us-ascii?Q?al2+fnUuIMc5jZaIaoqhkzUesLai41MlgLjZ97plfKoSLkYji1MlcBrpyA1d?=
 =?us-ascii?Q?QNcytlFul9+FAXCVHgrzC+6VcbQgsHoEA5gfihe2gQQqw2y2WJWcgybqxzuV?=
 =?us-ascii?Q?nXN0ZihOEXYB30S5uCD58J/CmxvNJh/Apx9JBC7ziueKSPAtiXwXCDgy3MDt?=
 =?us-ascii?Q?3eIQuEf/xxXomrG5A2pKsBAE8ldmgCE9Jv0SJiBO2/+yPXdOWs6kN50XOGyk?=
 =?us-ascii?Q?jYHWVhcu+Ykk+t+RjcRpszx+3d/2Q7pl1BnFH/UvyzIsezklETl/WkySBbJz?=
 =?us-ascii?Q?kOi/g6pbedvXo8hsgJLyKJxb2C2k8gZnbi+NgwOCeC2hiNx20xzGDB3eJQBI?=
 =?us-ascii?Q?WFTo2CBzm6XUjalf3UEsdmjbdZs16Vu9YFALZqjasMTolGAd4iX62c0rOhn9?=
 =?us-ascii?Q?gl6ntGAZLjF7rBg9Z0cF9x/+GocxScvCCr1AaM9Ex2HaAzBjkNFYAUL6ZgHP?=
 =?us-ascii?Q?z3oZqL9oc7YRvn24PWsAByaNkL8PDREe8ERulO2OfwowLG1N8qovPy7rB2HG?=
 =?us-ascii?Q?OgeuS6J3pMmyZQ2v8B9HHIHy5CcibeMMlLoyNCnPYAyBgWDtV9sKULGK7B1+?=
 =?us-ascii?Q?3KiF6lGkzvG4Uu/OF+kcVdOe6wzHBIn/3O+NsqrSm0z0J5gAENRYA4qfbebw?=
 =?us-ascii?Q?49jXqr+V7+3KavN4uVxLXm5TgVa7K89FVO6rNki4y7O3KNAlv3tSTxLdR7KI?=
 =?us-ascii?Q?1eHNfZt00QJgnj96Ecno8iLc6H9YudyB79AJOJwjmH9m/6onGd5HvWraXjED?=
 =?us-ascii?Q?r0AQI8sT9xCBST9IX9p2kTp0S+tly7qKgr2hjAqBQiix/6qzrQMiaB5BGOXH?=
 =?us-ascii?Q?OlvRWJGRjBRGLH1QfM1jDYZcIeavAlB/c1l+NyRZLlfPT8FLzkkYDV4t7CT3?=
 =?us-ascii?Q?yhV0lvXaONye1eSoK6nyU00=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c5e57e-be89-4e7f-4e21-08de3d7f46d9
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:39.2912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JZ6dB9yXjKs/zvwAdw+a44MfdhOKlRc6fvBng4/eYTD8XOgcvE1TJ68vkCf5d/dKTC6xwdLcHMvpSus++SfcVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

In eDMA-backed mode (use_remote_edma=1), ntb_transport can scale
throughput across multiple queue pairs without being constrained by
scarce PCI memory window space used for data-plane buffers. It contrasts
with the default backend mode, where even with a single queue pair, only
up to 15 in-flight descriptors fit in a 1 MiB MW.

Teach ntb_netdev to allocate multiple ntb_transport queue pairs and
expose them as a multi-queue net_device.

With this patch, up to N queue pairs are created, where N is chosen as
follows:

  - By default, N is num_online_cpus(), to give each CPU its own queue.
  - If the ntb_num_queues module parameter is non-zero, it overrides the
    default and requests that many queues.
  - In both cases the requested value is capped at a fixed upper bound
    to avoid unbounded allocations, and by the number of queue pairs
    actually available from ntb_transport.

If only one queue pair can be created (or ntb_num_queues=1 is set), the
driver effectively falls back to the previous single-queue behaviour.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 341 ++++++++++++++++++++++++++++-----------
 1 file changed, 243 insertions(+), 98 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index fbeae05817e9..7aeca35b46c5 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -53,6 +53,8 @@
 #include <linux/pci.h>
 #include <linux/ntb.h>
 #include <linux/ntb_transport.h>
+#include <linux/cpumask.h>
+#include <linux/slab.h>
 
 #define NTB_NETDEV_VER	"0.7"
 
@@ -70,26 +72,84 @@ static unsigned int tx_start = 10;
 /* Number of descriptors still available before stop upper layer tx */
 static unsigned int tx_stop = 5;
 
+/*
+ * Upper bound on how many queue pairs we will try to create even if
+ * ntb_num_queues or num_online_cpus() is very large. This is an
+ * arbitrary safety cap to avoid unbounded allocations.
+ */
+#define NTB_NETDEV_MAX_QUEUES  64
+
+/*
+ * ntb_num_queues == 0 (default) means:
+ *   - use num_online_cpus() as the desired queue count, capped by
+ *     NTB_NETDEV_MAX_QUEUES.
+ * ntb_num_queues > 0:
+ *   - try to create exactly ntb_num_queues queue pairs (again capped
+ *     by NTB_NETDEV_MAX_QUEUES), but fall back to the number of queue
+ *     pairs actually available from ntb_transport.
+ */
+static unsigned int ntb_num_queues;
+module_param(ntb_num_queues, uint, 0644);
+MODULE_PARM_DESC(ntb_num_queues,
+		 "Number of NTB netdev queue pairs to use (0 = per-CPU)");
+
+struct ntb_netdev;
+
+struct ntb_netdev_queue {
+	struct ntb_netdev *ntdev;
+	struct ntb_transport_qp *qp;
+	struct timer_list tx_timer;
+	u16 qid;
+};
+
 struct ntb_netdev {
 	struct pci_dev *pdev;
 	struct net_device *ndev;
-	struct ntb_transport_qp *qp;
-	struct timer_list tx_timer;
+	unsigned int num_queues;
+	struct ntb_netdev_queue *queues;
 };
 
 #define	NTB_TX_TIMEOUT_MS	1000
 #define	NTB_RXQ_SIZE		100
 
+static unsigned int ntb_netdev_default_queues(void)
+{
+	unsigned int n;
+
+	if (ntb_num_queues)
+		n = ntb_num_queues;
+	else
+		n = num_online_cpus();
+
+	if (!n)
+		n = 1;
+
+	if (n > NTB_NETDEV_MAX_QUEUES)
+		n = NTB_NETDEV_MAX_QUEUES;
+
+	return n;
+}
+
 static void ntb_netdev_event_handler(void *data, int link_is_up)
 {
-	struct net_device *ndev = data;
-	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *q = data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
+	bool any_up = false;
+	unsigned int i;
 
-	netdev_dbg(ndev, "Event %x, Link %x\n", link_is_up,
-		   ntb_transport_link_query(dev->qp));
+	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
+		   ntb_transport_link_query(q->qp), q->qid);
 
 	if (link_is_up) {
-		if (ntb_transport_link_query(dev->qp))
+		for (i = 0; i < dev->num_queues; i++) {
+			if (ntb_transport_link_query(dev->queues[i].qp)) {
+				any_up = true;
+				break;
+			}
+		}
+
+		if (any_up)
 			netif_carrier_on(ndev);
 	} else {
 		netif_carrier_off(ndev);
@@ -99,7 +159,9 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
 	struct sk_buff *skb;
 	int rc;
 
@@ -135,7 +197,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 
 enqueue_again:
-	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
+	rc = ntb_transport_rx_enqueue(q->qp, skb, skb->data,
+				      ndev->mtu + ETH_HLEN);
 	if (rc) {
 		dev_kfree_skb_any(skb);
 		ndev->stats.rx_errors++;
@@ -143,42 +206,37 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 }
 
-static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
-				      struct ntb_transport_qp *qp, int size)
+static int ntb_netdev_maybe_stop_tx(struct ntb_netdev_queue *q, int size)
 {
-	struct ntb_netdev *dev = netdev_priv(netdev);
+	struct net_device *ndev = q->ntdev->ndev;
+
+	if (ntb_transport_tx_free_entry(q->qp) >= size)
+		return 0;
+
+	netif_stop_subqueue(ndev, q->qid);
 
-	netif_stop_queue(netdev);
 	/* Make sure to see the latest value of ntb_transport_tx_free_entry()
 	 * since the queue was last started.
 	 */
 	smp_mb();
 
-	if (likely(ntb_transport_tx_free_entry(qp) < size)) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	if (likely(ntb_transport_tx_free_entry(q->qp) < size)) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 		return -EBUSY;
 	}
 
-	netif_start_queue(netdev);
-	return 0;
-}
-
-static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
-				    struct ntb_transport_qp *qp, int size)
-{
-	if (netif_queue_stopped(ndev) ||
-	    (ntb_transport_tx_free_entry(qp) >= size))
-		return 0;
+	netif_wake_subqueue(ndev, q->qid);
 
-	return __ntb_netdev_maybe_stop_tx(ndev, qp, size);
+	return 0;
 }
 
 static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
-	struct net_device *ndev = qp_data;
+	struct ntb_netdev_queue *q = qp_data;
+	struct ntb_netdev *dev = q->ntdev;
+	struct net_device *ndev = dev->ndev;
 	struct sk_buff *skb;
-	struct ntb_netdev *dev = netdev_priv(ndev);
 
 	skb = data;
 	if (!skb || !ndev)
@@ -194,13 +252,12 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 
 	dev_kfree_skb_any(skb);
 
-	if (ntb_transport_tx_free_entry(dev->qp) >= tx_start) {
+	if (ntb_transport_tx_free_entry(qp) >= tx_start) {
 		/* Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
@@ -208,16 +265,26 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 					 struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	u16 qid = skb_get_queue_mapping(skb);
+	struct ntb_netdev_queue *q;
 	int rc;
 
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	if (unlikely(!dev->num_queues))
+		goto err;
+
+	if (unlikely(qid >= dev->num_queues))
+		qid = qid % dev->num_queues;
 
-	rc = ntb_transport_tx_enqueue(dev->qp, skb, skb->data, skb->len);
+	q = &dev->queues[qid];
+
+	ntb_netdev_maybe_stop_tx(q, tx_stop);
+
+	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
 	if (rc)
 		goto err;
 
 	/* check for next submit */
-	ntb_netdev_maybe_stop_tx(ndev, dev->qp, tx_stop);
+	ntb_netdev_maybe_stop_tx(q, tx_stop);
 
 	return NETDEV_TX_OK;
 
@@ -229,80 +296,103 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 static void ntb_netdev_tx_timer(struct timer_list *t)
 {
-	struct ntb_netdev *dev = timer_container_of(dev, t, tx_timer);
+	struct ntb_netdev_queue *q = container_of(t, struct ntb_netdev_queue, tx_timer);
+	struct ntb_netdev *dev = q->ntdev;
 	struct net_device *ndev = dev->ndev;
 
-	if (ntb_transport_tx_free_entry(dev->qp) < tx_stop) {
-		mod_timer(&dev->tx_timer, jiffies + usecs_to_jiffies(tx_time));
+	if (ntb_transport_tx_free_entry(q->qp) < tx_stop) {
+		mod_timer(&q->tx_timer, jiffies + usecs_to_jiffies(tx_time));
 	} else {
-		/* Make sure anybody stopping the queue after this sees the new
+		/*
+		 * Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
 		smp_mb();
-		if (netif_queue_stopped(ndev))
-			netif_wake_queue(ndev);
+		netif_wake_subqueue(ndev, q->qid);
 	}
 }
 
 static int ntb_netdev_open(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int rc, i, len;
-
-	/* Add some empty rx bufs */
-	for (i = 0; i < NTB_RXQ_SIZE; i++) {
-		skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-		if (!skb) {
-			rc = -ENOMEM;
-			goto err;
-		}
+	int rc = 0, i, len;
+	unsigned int q;
 
-		rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-					      ndev->mtu + ETH_HLEN);
-		if (rc) {
-			dev_kfree_skb(skb);
-			goto err;
+	/* Add some empty rx bufs for each queue */
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		for (i = 0; i < NTB_RXQ_SIZE; i++) {
+			skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+			if (!skb) {
+				rc = -ENOMEM;
+				goto err;
+			}
+
+			rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
+						      ndev->mtu + ETH_HLEN);
+			if (rc) {
+				dev_kfree_skb(skb);
+				goto err;
+			}
 		}
-	}
 
-	timer_setup(&dev->tx_timer, ntb_netdev_tx_timer, 0);
+		timer_setup(&queue->tx_timer, ntb_netdev_tx_timer, 0);
+	}
 
 	netif_carrier_off(ndev);
-	ntb_transport_link_up(dev->qp);
-	netif_start_queue(ndev);
+
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
+
+	netif_tx_start_all_queues(ndev);
 
 	return 0;
 
 err:
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
+
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 	return rc;
 }
 
 static int ntb_netdev_close(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
+	unsigned int q;
 	int len;
 
-	ntb_transport_link_down(dev->qp);
+	netif_tx_stop_all_queues(ndev);
+
+	for (q = 0; q < dev->num_queues; q++) {
+		queue = &dev->queues[q];
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+		ntb_transport_link_down(queue->qp);
 
-	timer_delete_sync(&dev->tx_timer);
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
 
+		timer_delete_sync(&queue->tx_timer);
+	}
 	return 0;
 }
 
 static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
-	int len, rc;
+	unsigned int q, i;
+	int len, rc = 0;
 
-	if (new_mtu > ntb_transport_max_size(dev->qp) - ETH_HLEN)
+	if (new_mtu > ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN)
 		return -EINVAL;
 
 	if (!netif_running(ndev)) {
@@ -311,41 +401,54 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 	}
 
 	/* Bring down the link and dispose of posted rx entries */
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_down(dev->queues[0].qp);
 
 	if (ndev->mtu < new_mtu) {
-		int i;
-
-		for (i = 0; (skb = ntb_transport_rx_remove(dev->qp, &len)); i++)
-			dev_kfree_skb(skb);
+		for (q = 0; q < dev->num_queues; q++) {
+			queue = &dev->queues[q];
 
-		for (; i; i--) {
-			skb = netdev_alloc_skb(ndev, new_mtu + ETH_HLEN);
-			if (!skb) {
-				rc = -ENOMEM;
-				goto err;
-			}
-
-			rc = ntb_transport_rx_enqueue(dev->qp, skb, skb->data,
-						      new_mtu + ETH_HLEN);
-			if (rc) {
+			for (i = 0;
+			     (skb = ntb_transport_rx_remove(queue->qp, &len));
+			     i++)
 				dev_kfree_skb(skb);
-				goto err;
+
+			for (; i; i--) {
+				skb = netdev_alloc_skb(ndev,
+						       new_mtu + ETH_HLEN);
+				if (!skb) {
+					rc = -ENOMEM;
+					goto err;
+				}
+
+				rc = ntb_transport_rx_enqueue(queue->qp, skb,
+							      skb->data,
+							      new_mtu +
+							      ETH_HLEN);
+				if (rc) {
+					dev_kfree_skb(skb);
+					goto err;
+				}
 			}
 		}
 	}
 
 	WRITE_ONCE(ndev->mtu, new_mtu);
 
-	ntb_transport_link_up(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_link_up(dev->queues[q].qp);
 
 	return 0;
 
 err:
-	ntb_transport_link_down(dev->qp);
+	for (q = 0; q < dev->num_queues; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
+
+		ntb_transport_link_down(queue->qp);
 
-	while ((skb = ntb_transport_rx_remove(dev->qp, &len)))
-		dev_kfree_skb(skb);
+		while ((skb = ntb_transport_rx_remove(queue->qp, &len)))
+			dev_kfree_skb(skb);
+	}
 
 	netdev_err(ndev, "Error changing MTU, device inoperable\n");
 	return rc;
@@ -404,6 +507,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	struct net_device *ndev;
 	struct pci_dev *pdev;
 	struct ntb_netdev *dev;
+	unsigned int q, desired_queues;
 	int rc;
 
 	ntb = dev_ntb(client_dev->parent);
@@ -411,7 +515,9 @@ static int ntb_netdev_probe(struct device *client_dev)
 	if (!pdev)
 		return -ENODEV;
 
-	ndev = alloc_etherdev(sizeof(*dev));
+	desired_queues = ntb_netdev_default_queues();
+
+	ndev = alloc_etherdev_mq(sizeof(*dev), desired_queues);
 	if (!ndev)
 		return -ENOMEM;
 
@@ -420,6 +526,15 @@ static int ntb_netdev_probe(struct device *client_dev)
 	dev = netdev_priv(ndev);
 	dev->ndev = ndev;
 	dev->pdev = pdev;
+	dev->num_queues = 0;
+
+	dev->queues = kcalloc(desired_queues, sizeof(*dev->queues),
+			      GFP_KERNEL);
+	if (!dev->queues) {
+		rc = -ENOMEM;
+		goto err_free_netdev;
+	}
+
 	ndev->features = NETIF_F_HIGHDMA;
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
@@ -436,26 +551,51 @@ static int ntb_netdev_probe(struct device *client_dev)
 	ndev->min_mtu = 0;
 	ndev->max_mtu = ETH_MAX_MTU;
 
-	dev->qp = ntb_transport_create_queue(ndev, client_dev,
-					     &ntb_netdev_handlers);
-	if (!dev->qp) {
+	for (q = 0; q < desired_queues; q++) {
+		struct ntb_netdev_queue *queue = &dev->queues[q];
+
+		queue->ntdev = dev;
+		queue->qid = q;
+		queue->qp = ntb_transport_create_queue(queue, client_dev,
+						       &ntb_netdev_handlers);
+		if (!queue->qp)
+			break;
+
+		dev->num_queues++;
+	}
+
+	if (!dev->num_queues) {
 		rc = -EIO;
-		goto err;
+		goto err_free_queues;
 	}
 
-	ndev->mtu = ntb_transport_max_size(dev->qp) - ETH_HLEN;
+	rc = netif_set_real_num_tx_queues(ndev, dev->num_queues);
+	if (rc)
+		goto err_free_qps;
+
+	rc = netif_set_real_num_rx_queues(ndev, dev->num_queues);
+	if (rc)
+		goto err_free_qps;
+
+	ndev->mtu = ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN;
 
 	rc = register_netdev(ndev);
 	if (rc)
-		goto err1;
+		goto err_free_qps;
 
 	dev_set_drvdata(client_dev, ndev);
-	dev_info(&pdev->dev, "%s created\n", ndev->name);
+	dev_info(&pdev->dev, "%s created with %u queue pairs\n",
+		 ndev->name, dev->num_queues);
 	return 0;
 
-err1:
-	ntb_transport_free_queue(dev->qp);
-err:
+err_free_qps:
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+err_free_queues:
+	kfree(dev->queues);
+
+err_free_netdev:
 	free_netdev(ndev);
 	return rc;
 }
@@ -464,9 +604,14 @@ static void ntb_netdev_remove(struct device *client_dev)
 {
 	struct net_device *ndev = dev_get_drvdata(client_dev);
 	struct ntb_netdev *dev = netdev_priv(ndev);
+	unsigned int q;
+
 
 	unregister_netdev(ndev);
-	ntb_transport_free_queue(dev->qp);
+	for (q = 0; q < dev->num_queues; q++)
+		ntb_transport_free_queue(dev->queues[q].qp);
+
+	kfree(dev->queues);
 	free_netdev(ndev);
 }
 
-- 
2.51.0


