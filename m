Return-Path: <dmaengine+bounces-6937-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B153BFF87F
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AFC1502A9A
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1A02DEA76;
	Thu, 23 Oct 2025 07:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GeVw6kO5"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010016.outbound.protection.outlook.com [52.101.229.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2A22DA77F;
	Thu, 23 Oct 2025 07:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203969; cv=fail; b=kxZcity/lwfcFgj5uu6G8fOc5KjAonmE1HDdGqJij5h5FsrBPy/DvKraJ+Q2jNSG7DUe3w91b+swh4CXhSb7iXhVp/QyH1v5Thhb4MPIE3ZvYCuzTt1bRfCsXn2Nh5po7fbkxpa2GbKlERIDFswVI+2WMk77FtjmDZo62dNrrOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203969; c=relaxed/simple;
	bh=GGZG800jBLkONYisiaJ+eV/sNBaqpbjLwt+UEdUldzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qT/6gS7aCQP7NrtI1xUAJEtltmFhKhNhHO18lWQoqGD4dPZPSrDLlmpgEXZS+UEwBkv5G58MvQ8aoPzE8+NiUJnetKfk7rJXtzypFxEe7xBgMK3smYkMjN7cw7rEDKf7uGWrd6hLlZqvRPFoUL+qIMXtj5xDUlMZARQni5zCrO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GeVw6kO5; arc=fail smtp.client-ip=52.101.229.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QtLnvJFvIpyf6zWuhiWLdjEqrjTg1kGx38FhGJtS0vxFSv4W8kIfHesz+e7Rum2nOBmiY8fwiQ+7Ke3zWM9JUoeWoW1jG8lxhAe6BjPRVL/+35Xv6seXmJ/7NuOZprnwVdaldEBSio5XW8w4kMY9McHds6L0oCZ6Kt+ak4toXTlZHur6qysxNKrs4pNZTXvDY6/+03eYCRUOidF2kGJsidHr3NhIqVj/rtyH1E5kCD1dgkUXUcKtTj28g5olAulq7bpiDrSuwUk3gLK1JlKk1fu5bjqdBE25e+ILoY39pbvUpGaKfBY3wKgwsnvQ7LoE9xpm9dVmhVwlt90FYde0kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX57IsAeReO1+bV31cUwGNzJUOPUeNIDaVWEQTlUbr0=;
 b=QHV92Yc2Sv/R6JAl8UW6JdqiPPFA5CNT4zQK93b8S2yQ3+ro+u6zVVvYLRI4QYmNFfsVdhCZbAqUeCfpQScEODA7t7sW3vZWounEYW+rmza4azZFm6TRB5Z28cpg2rKjwMrAp6OOhJizdR5/1UTKED+V+/oWuegSjB7PuR8jz/fa6/2n/cz1ylKcr1oSD4K0R2rSZHG6B+16ixu1MHWsdBIXZGWgFo/EUqPUhI9O4Bdpm5s+ZTV2FHU9gd3JmZ3rvA3z4z5NPo9HavfYiOZpLob/1yQ3IFLgf52i0qYVAanFF1qiC0PGTPrB/gb/GekxsDrcGl0kVyh3WHx6vhdvGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX57IsAeReO1+bV31cUwGNzJUOPUeNIDaVWEQTlUbr0=;
 b=GeVw6kO57N2vZ+YXoMjuvlP55+PHdVF0xsm6h2EvM902i8YREWwc6rhZrr+qjpxQRRqAFJQjLx5snhhOFFhAIwny+SvxcbhOgdYl6eTWW4+ZQthTUrairVaVgsJdPbSQ81IqqwB0IXAikeaEwiyoaQnw3Nad/etMyVcBdEPi1xM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TY7P286MB5387.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:24 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:24 +0000
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
Subject: [RFC PATCH 02/25] PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
Date: Thu, 23 Oct 2025 16:18:53 +0900
Message-ID: <20251023071916.901355-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:405:36c::14) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TY7P286MB5387:EE_
X-MS-Office365-Filtering-Correlation-Id: 658e70e2-1cc9-42ea-030f-08de12047e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/HPnpe89Z4vxCsbz9ynIzDF54qgPjixwn1QJSugF8zDBtRRinaqDiS0m/Ru8?=
 =?us-ascii?Q?A9tizFwaCKEvLPW/eftmNajmJK4aePX9SSQKteDLJsvL+PNKStnHv0wedhQ1?=
 =?us-ascii?Q?T9dKvL1ktOQs0hFpH9+yRRK1j2VN4wREI/c94e6ueDSbb50BtxF0O/JxGJfQ?=
 =?us-ascii?Q?+4npCDvJt4GTrXNCz2npJ+YYPjl875ReK45zY8biNz1sp2BJpBTyisUZAiyQ?=
 =?us-ascii?Q?r5d8dvUJBCroa+rJLDLvpScXl2qd/4LNWt7bznIFqQSCJLaGzg2NUYQ1ggol?=
 =?us-ascii?Q?mdGLxK4A6GTSyfZ1RnXFzOutYZI2grqd8F/hrCrgw9e/Aqha9K7qXG2jgAnb?=
 =?us-ascii?Q?+kL//PuVlesZ/GUOYs0YLHKkkdqIBNRlPpwMfMMlcGF5w3qY9qIsrqdyctkw?=
 =?us-ascii?Q?3WI7yzPgG5V2Zu09ElRLO2fEKcH6+JOcpwBOM8gL1VkbloiSihgT8d7OLkdf?=
 =?us-ascii?Q?hvzRTK6J0E9SnhavYMjs4J+O4MRKD7VHFg/l+316Gb6YAWGv4LuRxogNaX1S?=
 =?us-ascii?Q?5gUPDCtNHdRN7Qe9pvgrXLit53AE8BE4NLmYrLt8s1kKuzVr8qg149wTRrLu?=
 =?us-ascii?Q?gHC8rvvhM24M6gTzDE6zV6SOQ82gSX5CfMNcbZNEc9vktefgtXyx3MXM+lnO?=
 =?us-ascii?Q?r8rbR1ZKSoCF2Nf5D2S96l4L4xWNQNIuewyqNZOOjNcl2WqMy6b1WikkWIki?=
 =?us-ascii?Q?3jwkCDIvxLWo9tulRddeqK0rNrA/HNSE6Xo2/6Cfy3w9h5pbregzUjSbhD6V?=
 =?us-ascii?Q?mulgFx851/U9OVUO1MRCwjOkgukYtLdWqMBnneerWLxNq+SwGek95eFCOS9a?=
 =?us-ascii?Q?BOjkh8rTy8nq/kaXYwoa3hQBQLiul/yvCNMP3X7+E/SJPIy8RQdU0yeY7mcK?=
 =?us-ascii?Q?nINeildMNdUlgreXxQm1pGeoZNL7WmggU1zdpfoO8U/yJX+9YxoDVTjb92cs?=
 =?us-ascii?Q?h2GGt1TDEGcFgpt5UZSHmUtb+oVa4L81z6Kg6WGOGjpcYW3dKsiRjaDshb4z?=
 =?us-ascii?Q?0IB7Ogm8kOE8g8ud+owLhm4HfZ1NpaNTh2/23xD+JJ5uL35UI8fwz4oEXePF?=
 =?us-ascii?Q?dxZdMAUGMfAbbZyce8MOpai9uDypfGHzDMKRcFBsXaMYWTYc0nCyvVSXGDhj?=
 =?us-ascii?Q?nzyAA/m3wM5OsE7Llycam82WfjOouqNxM6hsmuGWN06Pv/H1hR49g8nXhP0Z?=
 =?us-ascii?Q?pqRsh4WPR0JdN62YwV41OtxVIKF1u4ByOdi0zjw26GhoIYXOZ7/Zd6bwh5jx?=
 =?us-ascii?Q?XIRWxav8XLq9CXJ/DznvaCmg505NSYv8kZgJ+0ZQupvBNf5F5Mn75XFffq/0?=
 =?us-ascii?Q?jo/6uy3EMzSkYYsSiWQtcn0i0I/iCxTa1ryOZdnjWyxmBL/ktVTpQMZVYQGB?=
 =?us-ascii?Q?UFsTZBQ06eoelqdNISZ6oh76/VVqZuHrGxeC0bqt+uDSJY5QKk1RGdgyBD2b?=
 =?us-ascii?Q?0Ia+o7fTL/tPh6V5WesIJbedE6/trAv+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mDEtQnBEUszCk49mIwU48sjvV0QO8Z0UaHfycpml8qvzexiIYgaAI1ozVd09?=
 =?us-ascii?Q?bgLJN1ic5YoHkOeEDwvLny7hkKlTo1lJeTg424RwSAFz90rk64cv2rsTK+N1?=
 =?us-ascii?Q?Kd0JQfaW5axAXU+VHlX00p6Vummq1FOws3+/dx85WzKxVbGpWqhLwSrbXqA7?=
 =?us-ascii?Q?rRvZNDlxPN1NeY8A3si87PLZwVNvONzhtKtTvyipVJCItIU/KujeWtmeh+V/?=
 =?us-ascii?Q?k7IMTRXkGJPyaqcvS6MfS0I4Oari7KIqCJD5icim2BlKSU2v6crja3jVFY8B?=
 =?us-ascii?Q?HzSfJh0Au8T8kUi1L5B+VLOQKMIl/sZWmHApkq/uOUweQV2zDPXfoFM3f+s7?=
 =?us-ascii?Q?gwRYnHXs+fXxBFS/32zQwekmAZXHb0SoeHRxlUhxxsAH0Q5fqodlL69PVVkX?=
 =?us-ascii?Q?3OnGwjMwt+qi/8/uT9pcmT5+hpFvOgr/huxtUAoKjfDC34Nx8QZ76mnkcX00?=
 =?us-ascii?Q?LBSKpBMEyFg10bvmncyb93UxSoBUCqy1MXnHp8foPZjoIdI1iMllet2beTsb?=
 =?us-ascii?Q?G4w5GyOcc46ZCbrxwp9HlanIuv1obvlQuHxuxXtegx7Yt6fTI7NH7ihmFmwL?=
 =?us-ascii?Q?d1e66SuFD/HEIIu3AbAWpRU4w3TjSVRTSazc6/woZstSIr0I6CEtCxjxEx+g?=
 =?us-ascii?Q?2kB5F7yDv6MXy69XPmtuQ5JD5k3jk64wlZThbccyAaYjG/n7w0lmGERcY8NG?=
 =?us-ascii?Q?pwBLhbh2KbfY8u8UOg/ov+g6wYept/5DAaHx1aIS4DzBQKAywIApCkW2IQlW?=
 =?us-ascii?Q?pmxmyGvRLBi8UOTUEvtyCjtorvSrjoM7ReCYZwThnjCE4NJuSY8pKUA+Jo13?=
 =?us-ascii?Q?O3A4CW1jpB7TwYPydy2a3aSE7lLMTvQBkGA3eW0lM81KUBmb+WwJZ4SBo/E0?=
 =?us-ascii?Q?nj6H+qx+6qViScNM7hMuLFkec76w5fZ97S9INp+hqG6/4RlFoH5OURfTOKW5?=
 =?us-ascii?Q?xtDXHjfzM+Xe4g/WWj+kPKZKaOeM1IMQ/o+z+1WZ3F6nAHts2urT9cjunWyS?=
 =?us-ascii?Q?Pi1BPRthJ6KMHrWZQGwRZ3jzQ4Bf0Gnw1JViTjiE8SoNIabmBC8Qruw3alFW?=
 =?us-ascii?Q?QUNXUES2x56D6Eb8ApuX1CXKAURmlvMq+qfUpIFE9rrKk8eTYxUnYPOlrhas?=
 =?us-ascii?Q?2A/9BeeLdzNiQ2o+b1c4fuNsct/oAgo+1xPEDKlL4OQl0pwzc/YuOZdGwLkr?=
 =?us-ascii?Q?u7ckSJtrgTK6f8YSKESvWA2ZxJ/n+drAAgex1tKcBHMVZV9CJA3SXAKsZhuQ?=
 =?us-ascii?Q?UKGxGxMqOx9U4e0q5xIi65kJwqKDCrJGOI2J2npRbiyZQ9lbA3R3Sbd3N1e8?=
 =?us-ascii?Q?ZlkQQroC3/ODr50ByJGOPEATl1Smba8CPxxhapor3pNJGPsLnRftzRjpcNg9?=
 =?us-ascii?Q?7Eo8WHw3fpR5Y3b62VUdVOlbmMry5HfPR76Ps4Qk293wbvNmdxGSInjOWmpC?=
 =?us-ascii?Q?92M9yehJgx1zExv/SnDTXJBYt1nG+Y8KWDJfHz3RqtoNY08eXXyancWbpxdX?=
 =?us-ascii?Q?PRyltAY82pRk3HUup1+uxr5+wHJzaAxLgBlOxw4ZAEx59BjG+b2eFPyPo2YQ?=
 =?us-ascii?Q?Awxn7bIlyqHHbrIK5e8EnCe4ohbw7kcGpSdXLNTxveilvBGGzLw8ZlLonnWS?=
 =?us-ascii?Q?Tj0gQJD6Kzh5L+V/MnQjFk4=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 658e70e2-1cc9-42ea-030f-08de12047e53
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:24.3211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 72ouAP6OTlRWcyWozJic1LHVeYyjI+710Bw6pXFS034SO4hLI5fdg+j5sJqhCKOG4wZ2euCGuBrTppPqRyO3uA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5387

Introduce new mwN_offset configfs attributes to specify memory window
offsets. This enables mapping multiple windows into a single BAR at
arbitrary offsets, improving layout flexibility.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 133 ++++++++++++++++--
 1 file changed, 120 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 55307cd613c9..6953abb2987d 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -38,6 +38,7 @@
 
 #include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/log2.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 
@@ -109,7 +110,8 @@ struct epf_ntb_ctrl {
 	u64 addr;
 	u64 size;
 	u32 num_mws;
-	u32 reserved;
+	u32 mw_offset[MAX_MW];
+	u32 mw_size[MAX_MW];
 	u32 spad_offset;
 	u32 spad_count;
 	u32 db_entry_size;
@@ -126,6 +128,7 @@ struct epf_ntb {
 	u32 db_count;
 	u32 spad_count;
 	u64 mws_size[MAX_MW];
+	u64 mws_offset[MAX_MW];
 	u64 db;
 	u32 vbus_number;
 	u16 vntb_pid;
@@ -441,6 +444,8 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 
 	ctrl->spad_count = spad_count;
 	ctrl->num_mws = ntb->num_mws;
+	memset(ctrl->mw_offset, 0, sizeof(ctrl->mw_offset));
+	memset(ctrl->mw_size, 0, sizeof(ctrl->mw_size));
 	ntb->spad_size = spad_size;
 
 	ctrl->db_entry_size = sizeof(u32);
@@ -570,15 +575,31 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
  */
 static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 {
+	struct device *dev = &ntb->epf->dev;
+	u64 bar_ends[BAR_5 + 1] = { 0 };
+	unsigned long bars_used = 0;
+	enum pci_barno barno;
+	u64 off, size, end;
 	int ret = 0;
 	int i;
-	u64 size;
-	enum pci_barno barno;
-	struct device *dev = &ntb->epf->dev;
 
 	for (i = 0; i < ntb->num_mws; i++) {
-		size = ntb->mws_size[i];
 		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
+		off = ntb->mws_offset[i];
+		size = ntb->mws_size[i];
+		end = off + size;
+		if (end > bar_ends[barno])
+			bar_ends[barno] = end;
+		bars_used |= BIT(barno);
+	}
+
+	for (barno = BAR_0; barno <= BAR_5; barno++) {
+		if (!(bars_used & BIT(barno)))
+			continue;
+		if (bar_ends[barno] < SZ_4K)
+			size = SZ_4K;
+		else
+			size = roundup_pow_of_two(bar_ends[barno]);
 
 		ntb->epf->bar[barno].barno = barno;
 		ntb->epf->bar[barno].size = size;
@@ -594,8 +615,12 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 				      &ntb->epf->bar[barno]);
 		if (ret) {
 			dev_err(dev, "MW set failed\n");
-			goto err_alloc_mem;
+			goto err_set_bar;
 		}
+	}
+
+	for (i = 0; i < ntb->num_mws; i++) {
+		size = ntb->mws_size[i];
 
 		/* Allocate EPC outbound memory windows to vpci vntb device */
 		ntb->vpci_mw_addr[i] = pci_epc_mem_alloc_addr(ntb->epf->epc,
@@ -604,19 +629,31 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 		if (!ntb->vpci_mw_addr[i]) {
 			ret = -ENOMEM;
 			dev_err(dev, "Failed to allocate source address\n");
-			goto err_set_bar;
+			goto err_alloc_mem;
 		}
 	}
 
+	for (i = 0; i < ntb->num_mws; i++) {
+		ntb->reg->mw_offset[i] = (u32)ntb->mws_offset[i];
+		ntb->reg->mw_size[i] = (u32)ntb->mws_size[i];
+	}
+
 	return ret;
 
-err_set_bar:
-	pci_epc_clear_bar(ntb->epf->epc,
-			  ntb->epf->func_no,
-			  ntb->epf->vfunc_no,
-			  &ntb->epf->bar[barno]);
 err_alloc_mem:
-	epf_ntb_mw_bar_clear(ntb, i);
+	while (--i >= 0)
+		pci_epc_mem_free_addr(ntb->epf->epc,
+				      ntb->vpci_mw_phy[i],
+				      ntb->vpci_mw_addr[i],
+				      ntb->mws_size[i]);
+err_set_bar:
+	while (--barno >= BAR_0)
+		if (bars_used & BIT(barno))
+			pci_epc_clear_bar(ntb->epf->epc,
+					  ntb->epf->func_no,
+					  ntb->epf->vfunc_no,
+					  &ntb->epf->bar[barno]);
+
 	return ret;
 }
 
@@ -922,6 +959,60 @@ static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
 	return len;							\
 }
 
+#define EPF_NTB_MW_OFF_R(_name)						\
+static ssize_t epf_ntb_##_name##_show(struct config_item *item,		\
+				      char *page)			\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no, idx;						\
+									\
+	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
+		return -EINVAL;						\
+									\
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
+		return -EINVAL;						\
+	}								\
+									\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	return sprintf(page, "%lld\n", ntb->mws_offset[idx]);		\
+}
+
+#define EPF_NTB_MW_OFF_W(_name)						\
+static ssize_t epf_ntb_##_name##_store(struct config_item *item,	\
+				       const char *page, size_t len)	\
+{									\
+	struct config_group *group = to_config_group(item);		\
+	struct epf_ntb *ntb = to_epf_ntb(group);			\
+	struct device *dev = &ntb->epf->dev;				\
+	int win_no, idx;						\
+	u64 val;							\
+	int ret;							\
+									\
+	ret = kstrtou64(page, 0, &val);					\
+	if (ret)							\
+		return ret;						\
+									\
+	if (sscanf(#_name, "mw%d_offset", &win_no) != 1)		\
+		return -EINVAL;						\
+									\
+	idx = win_no - 1;						\
+	if (idx < 0 || idx >= ntb->num_mws) {				\
+		dev_err(dev, "MW%d out of range (num_mws=%d)\n",	\
+			win_no, ntb->num_mws);				\
+		return -EINVAL;						\
+	}								\
+									\
+	idx = array_index_nospec(idx, ntb->num_mws);			\
+	ntb->mws_offset[idx] = val;					\
+									\
+	return len;							\
+}
+
 #define EPF_NTB_BAR_R(_name, _id)					\
 	static ssize_t epf_ntb_##_name##_show(struct config_item *item,	\
 					      char *page)		\
@@ -992,6 +1083,14 @@ EPF_NTB_MW_R(mw3)
 EPF_NTB_MW_W(mw3)
 EPF_NTB_MW_R(mw4)
 EPF_NTB_MW_W(mw4)
+EPF_NTB_MW_OFF_R(mw1_offset)
+EPF_NTB_MW_OFF_W(mw1_offset)
+EPF_NTB_MW_OFF_R(mw2_offset)
+EPF_NTB_MW_OFF_W(mw2_offset)
+EPF_NTB_MW_OFF_R(mw3_offset)
+EPF_NTB_MW_OFF_W(mw3_offset)
+EPF_NTB_MW_OFF_R(mw4_offset)
+EPF_NTB_MW_OFF_W(mw4_offset)
 EPF_NTB_BAR_R(ctrl_bar, BAR_CONFIG)
 EPF_NTB_BAR_W(ctrl_bar, BAR_CONFIG)
 EPF_NTB_BAR_R(db_bar, BAR_DB)
@@ -1012,6 +1111,10 @@ CONFIGFS_ATTR(epf_ntb_, mw1);
 CONFIGFS_ATTR(epf_ntb_, mw2);
 CONFIGFS_ATTR(epf_ntb_, mw3);
 CONFIGFS_ATTR(epf_ntb_, mw4);
+CONFIGFS_ATTR(epf_ntb_, mw1_offset);
+CONFIGFS_ATTR(epf_ntb_, mw2_offset);
+CONFIGFS_ATTR(epf_ntb_, mw3_offset);
+CONFIGFS_ATTR(epf_ntb_, mw4_offset);
 CONFIGFS_ATTR(epf_ntb_, vbus_number);
 CONFIGFS_ATTR(epf_ntb_, vntb_pid);
 CONFIGFS_ATTR(epf_ntb_, vntb_vid);
@@ -1030,6 +1133,10 @@ static struct configfs_attribute *epf_ntb_attrs[] = {
 	&epf_ntb_attr_mw2,
 	&epf_ntb_attr_mw3,
 	&epf_ntb_attr_mw4,
+	&epf_ntb_attr_mw1_offset,
+	&epf_ntb_attr_mw2_offset,
+	&epf_ntb_attr_mw3_offset,
+	&epf_ntb_attr_mw4_offset,
 	&epf_ntb_attr_vbus_number,
 	&epf_ntb_attr_vntb_pid,
 	&epf_ntb_attr_vntb_vid,
-- 
2.48.1


