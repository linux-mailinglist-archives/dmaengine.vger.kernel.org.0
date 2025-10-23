Return-Path: <dmaengine+bounces-6946-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 186BABFF921
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 09:28:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FDA93AEBC4
	for <lists+dmaengine@lfdr.de>; Thu, 23 Oct 2025 07:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE752F39A6;
	Thu, 23 Oct 2025 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="taNX5cAj"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011034.outbound.protection.outlook.com [40.107.74.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CBE2F12D6;
	Thu, 23 Oct 2025 07:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203983; cv=fail; b=rTaSfRZdsf2RkKwGTfAl0eI7E9MCuuG1M0ErS6YE5/aoBX7QQhYAZg45in+lJI/jJYoVD044eLtsIIh3nMn1QHxQkMHFCvGpQaumnncXBXYuXZuItDACFYRti3lR2rzu4zjRi+jEuX4PvrJlRrBm52nz+E7kPB9TCmCY6GHiB+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203983; c=relaxed/simple;
	bh=u8JsFWL5cBku2oub0iKfCjbfXYoOTYHXjbXtVdMKdX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=a2CVJOWxU5/aZzYutLOECocmmPjqu5Ak0owbN/nppmYvH0kmV1cRB+qDcq2z9v+5fRkeZa1LTAVHGFRiOg1m+QKoVo0pBkM/gaAocMp8BleNjLvaVj7OrRSNfbJ7+OrSJauNDpyteqFru/d+sLUbyaBFDlTFUuijwBKsYuDnhCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=taNX5cAj; arc=fail smtp.client-ip=40.107.74.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlOcLfzVC02coVgdopTtnRQoiB7MpUvxh7yQhN5vEq29QV+h/Xyw7WQflBltS/OrmlTBlcXRUuNBUk8VDi979fo1N3tALkNvATreVP0CLymtRnX207aGBnUo0p0x2JsNJ/fOmIdJ+DpyEDLrLi5tdXJhbH2/HrxLlmBXJZQHI2lf8kSkK2lVpf++9sSiE6MsENt7d9bRA5zSAC+YSbTbYTSPLxSfSN77r130XF0Ga8CceiTgZh8ZSg2xZUobrcXMJxoxAnhjr5tCbtefZzavWOTtQVlTTAtp0y6MEZgwC5MuJuQqU5201PXtKVx3xAzp4ngEJ5vWR7twzdC0iqMYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/EtLT+x/P+lGngOmnadz0o992b2+4nOgjuT6L6qvVL4=;
 b=Es5Xist7Or4lpWRX6oBimCrevqIkcUUIk0U6EsJB7dRB0dCTYy26TLXHF/3/oQWMb1EAiS3aYUj4/G6Uoo1DpnIrNKlPaFoXFVyTc6UD6Am5zfiIfJgQWDX/95r+/i0nSnPhntF4OnVUicy8PpwwIOQP2LBG+mtHKYEjpHl5y1tvdpA6K/gEsYYdzNls5S+h5k1N3xiLNNtVCCOrJBWbf+0RuLoY9kGzOlonjslxIyHOxLXorTacz0zCX9c8FJIJzjMiJUBgpS+s5gJ6NhgIXwTrNaG4iZhJDjoHNsT3yF+IoJYYQTfW8cXwbOv590h4/3FmCIx7TaZ/wdvkIbHECg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/EtLT+x/P+lGngOmnadz0o992b2+4nOgjuT6L6qvVL4=;
 b=taNX5cAjPWsT0et5PrngaxuUAa/zztDJ23IpnWvAsj5W67qLyN5kjk08lo98nHBIki97O1obgcYQDQ0U4fxm1kC4b3wKA4zO8d9re0se68f7m7WgBEAJYKuG7IMz+UFpiC0coj3cCqigfKjRSgWqrmX4pxUOJ94mYJfTud8g2os=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OS7P286MB7183.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:19:36 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:19:36 +0000
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
Subject: [RFC PATCH 11/25] NTB/msi: Do not force MW to its maximum possible size
Date: Thu, 23 Oct 2025 16:19:02 +0900
Message-ID: <20251023071916.901355-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023071916.901355-1-den@valinux.co.jp>
References: <20251023071916.901355-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::8) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OS7P286MB7183:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e1fb67c-882c-454c-2422-08de1204855f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jYvPPemefKRfx12ZUuY0G0dvY5d/rqBKPUuzgxmb/y0rC74IeOwZ3c1YOe1S?=
 =?us-ascii?Q?gKP89xS5ursZlPI7vS5LOl8YDPP+EUmgc2zZdDMvRd7q0hdxHjdoC2SL4bi6?=
 =?us-ascii?Q?awm92tNusbkTMrSBcLAsATLIQTfpTEybI5howzizSvZrIEp2MmwgoFWtNXqR?=
 =?us-ascii?Q?XknEjxxgwLsrnAFJKPuejNCbDC0dwSdjB4FI67XHNg5geAXGhHMBtOrnnL5n?=
 =?us-ascii?Q?f+OO/DigWiwRmPI3GG0RAJFm26ajI5gtbviKA8DZeHoATUoPj7J/OOtHzsbM?=
 =?us-ascii?Q?lpXVUrH/21SlSooYthTBHWonAfGJQl5TvWgvhbUpUYtVVzDWbAtSUucYk7au?=
 =?us-ascii?Q?Rdq0/XXu2TsgF9tg3syRfDUrRywh7QWCodaYDsarHEd2L52XXG8Bv33vCQWx?=
 =?us-ascii?Q?eRQXZn/T/DFlRu+zRN1My1DC1SvH3AfQqBtkZsC4cxaBQiK4/CwSjDNVRK6r?=
 =?us-ascii?Q?PO6VMvd3qXkwCFYR8ynmMDNA6PcbtJKCjhK/SGiU06d0yE5Q7FqsuZcO3T/e?=
 =?us-ascii?Q?e2ZztkD5QhgUpI9orYmxur+7a9Bgu0fyEKacs+YSvVpLou+2RkGHxd88Uded?=
 =?us-ascii?Q?tIfjJ1P+zhV0cykcfcG5Enkh4p0CUalbtp8oHLyMqyXqGfmkNjzxvnw6Mdvw?=
 =?us-ascii?Q?8iOk4KOGeFMdr9l3rV2vDzEmHo9Jilk+8PZvTCwyhcDt1xnxQogUC8MqwG8e?=
 =?us-ascii?Q?/22uKHhBYg/0rruHGEPVpsTq9MXNiOrw3oE3FbLOWtVyI0T9O/vkeoHJmEik?=
 =?us-ascii?Q?CjVBfS0pBYAJvmXjxO7Z416v9URh3y7NIR3YW4urt7g9nHPEGzKe2Vlern7r?=
 =?us-ascii?Q?+TpZuHW30yq5s01rXBT/kEAz8Rc8WCCIMrLgmJxJaaZF22bzzsi7+b742vnE?=
 =?us-ascii?Q?NpKbDBNQn6smd6Jg6oHlmJDcRovBHQ9XP3ULD50lrshFnPJTE25TOEceUjJZ?=
 =?us-ascii?Q?T8xOyC4nAFsuNKslqRjwrUOjEMddmnjjB3kM7FtEkUzCRFvXRuxlBPYbety0?=
 =?us-ascii?Q?npH3ARqsRm5ur70zyaazJce+btn/x3bzqo4EPUdxhdE8utxYwiOabMqj4fE/?=
 =?us-ascii?Q?zhuJEY7MG5gqOokf+n1CmH15cuux0NbWL22rpGvoDN1l21gWOrpsYrfhIGeA?=
 =?us-ascii?Q?UhtnGPTbw2fjkjulxGbKXhQ8y4KnFOShZZHVJvODqhheDEuo/zl+8ljaVn+S?=
 =?us-ascii?Q?9gja5HJCmASnhBXPrt/uDnyHNZKv5RhPw+Z4fK5cyuMFzAVTtE14C5XYzYSb?=
 =?us-ascii?Q?jHpr8zY5khn3nm+TR93OGbtWoJWLWVCiXLQpbrCoQcKW/TyUm+Las7EnJ2EQ?=
 =?us-ascii?Q?9MlP7sIbPSQDNfA0irEB7NS5BbhEfe121MlgHEsbfbFe/f2aqDqeXrp/4RrY?=
 =?us-ascii?Q?MhNofQ5KpSN8YOAqlxoGtNHuj8Dh9vRHcB+ksYHVgAaAFWxOdxDkyFAmoybv?=
 =?us-ascii?Q?+kP7yoamsk2BAuLn1XHJfWHCq+gKwvIN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oqt+GIuo1iXRSmh+2Qd8MmbIXK3JO+F6lEoKiJcRF7xwqrlxsbg+tAntMxja?=
 =?us-ascii?Q?cJpsA+PKPBjUWxzxQppyggJAgHnk9FjU2rDOSgLU3AojunpOFnm2OO8sv5LM?=
 =?us-ascii?Q?wrZS7MmmN3o48sOmrtSxKDVL94YaIR/7w1XGITX4fWIIjcbx+0LzRxW4locv?=
 =?us-ascii?Q?j0blprLD+MHjobRwIhSwM2J/WXs86tXcbJFxvfxE37402YI+ppY9Ym9lfXze?=
 =?us-ascii?Q?jL2tCma6nWP0PhM1rr4wheiXD0O87FQyVCtnJIUI7QoTGlOwZEwUsGiWUwfy?=
 =?us-ascii?Q?htqxrG6tDAeK2IniUCvhBI5izq1+Epd5JEOA32iWXJA5FUrAPwvDpW/E/J2D?=
 =?us-ascii?Q?i6mxzCYsGTj6NlWzpJ1jjTFheZ3gQa8AAkNk/V1K+9wUlgm1K9UIoOX7NOiC?=
 =?us-ascii?Q?ipnCc+Z+nSd3eVgjztBZdcoJJHZLspWC/CILd1vv4fXZho61nI4uY9a1jsWP?=
 =?us-ascii?Q?/AChNMLiJVdmzUAzPpyrWoBBJ6iDFDBQ4jRyBWg8oCCUuS/+3Vil0mlD6V1Y?=
 =?us-ascii?Q?7TUlgDNjTybx6qAdDe7eXWEICNlTQ0ZcJ2BZMx90mm/7u7KAe79MRNO50aWE?=
 =?us-ascii?Q?1/2/ABEAmROgswHLWH2qBapvw3VLyYmpDJxEzQcx9ttEAQqXkThR4nW2af/E?=
 =?us-ascii?Q?EhTbZkgeg7e7GeC4+RxvnbVipfJITyhJZBJIYNyjUGMk8NxlwgrJLYQa3y7P?=
 =?us-ascii?Q?hGexnbVoVruPTq8rUwwtT8zsdj/k3yn1hbqjl+6vAre/Q6eDMBIrdG8cTT4Z?=
 =?us-ascii?Q?hniCQJhUIozh8o9MGdU5FwDVyvlasHOjhT4h/7f7OI2aWlv59cVGZ2+gUAnZ?=
 =?us-ascii?Q?tKILIUDVfxIuk29v4MoSGydsVWtS91JeNCe0xwQFvXMmkg9YYnPiiFYT3GSZ?=
 =?us-ascii?Q?eDL9SC6jwXqHLyGmPTjV33Bs6SLnQJYz7Z7POmnEJxQq7BXyK+ixiQcKQ8+L?=
 =?us-ascii?Q?OX+JF/C1sm9kG7+2eDM1ifarLh6sdD2KKvrnJaIGdAas1JITBBb7AdMV28N4?=
 =?us-ascii?Q?lXe01qzh5DAygTtRBCDLsKmNehB9oEWye/PP/Zdk8tZxwDrl+SL4G/8hVO7X?=
 =?us-ascii?Q?Z39wJksT72oKf4zl7x2ams92FTV9ih2GAfUO//X/B+zo6gt94l00lco+FTbO?=
 =?us-ascii?Q?e+L7n5vQmJJVsDT4UKPzz0BvtcX105ijOf5BkiZPr3qdry5S56wnIR75Egp+?=
 =?us-ascii?Q?kfFMcnbdX2+yINRikjnRJLBT/4hJSe1mr+HL0STn7x3La6pV0DWg5182Ykkk?=
 =?us-ascii?Q?crpEnCM3Adtwa5tVBY6AWBguqqpWV+zDfXCVAilXt53kGmaVWAjbM/nq9bwk?=
 =?us-ascii?Q?jFJbgFYwj/QVArZwh3CDo7ERkfb4O+zIVR8G0y+y2twerq2pHJ2IJRL2jOTR?=
 =?us-ascii?Q?NAjuLLZA0dQR6eDhiy4lN4nRwHDeUCxyifXanNo4/MdWpg22G1bnsvc3rmtT?=
 =?us-ascii?Q?oLTbP4n2SgT7yJ+SrG7RYG3g7xxr1a44WRm9GRb0eD7BTcnve7u0dH/EFzdC?=
 =?us-ascii?Q?3hFbnTyTwBubv5Ay+M6iOx4uyPkXjGxhLAU1ONpsTRouFsj6XEuge4DMEzMw?=
 =?us-ascii?Q?JHNbLxnZDPJCDewBcOA3TZ8+cRIeDBu8WvfVP+2Gq8S5AmBpMofkLj7CF7TO?=
 =?us-ascii?Q?E8f/9EWvu41WCuKvaH8fhMA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e1fb67c-882c-454c-2422-08de1204855f
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:19:36.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3zQ+b1AL8AkJ7RHUt6J/Iisc8n9ByTqg5sfdZ83LjGA+8rk13niy48s7bU4HkGgGUG1FlhUUMrdivqH44y203g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7183

As partial BAR usage is now supported, stop rounding memory windows up
to the maximum possible size.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/msi.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 4dc134cf404f..00218cfa6fd5 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -97,7 +97,7 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 	struct msi_desc *desc;
 	u64 addr;
 	int peer, peer_widx;
-	resource_size_t addr_align, size_align, size_max, offset;
+	resource_size_t addr_align, size_align, offset;
 	resource_size_t mw_size = SZ_32K;
 	resource_size_t mw_min_size = mw_size;
 	int i;
@@ -132,12 +132,11 @@ int ntb_msi_setup_mws(struct ntb_dev *ntb)
 		}
 
 		ret = ntb_mw_get_align(ntb, peer, peer_widx, NULL,
-				       &size_align, &size_max, &offset);
+				       &size_align, NULL, &offset);
 		if (ret)
 			goto error_out;
 
 		mw_size = round_up(mw_size, size_align);
-		mw_size = max(mw_size, size_max);
 		if (mw_size < mw_min_size)
 			mw_min_size = mw_size;
 
-- 
2.48.1


