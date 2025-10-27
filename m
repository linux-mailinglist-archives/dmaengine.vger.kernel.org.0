Return-Path: <dmaengine+bounces-6993-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9003C0B8DC
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 01:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF2D188C71B
	for <lists+dmaengine@lfdr.de>; Mon, 27 Oct 2025 00:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B1B26CE2D;
	Mon, 27 Oct 2025 00:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="esYp3PsS"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011018.outbound.protection.outlook.com [40.107.74.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2981B87F2;
	Mon, 27 Oct 2025 00:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761526002; cv=fail; b=XOqaZZ+AjFNozu5jYXezgXD25s/+no0/duim5Wc0vfTToMpHkXe8K9TKbck84t7SxuseUg/safBaLAowN/wgUreXqmE6A/JLNsOlAQAWj7fC3I0oDqiqQXhx1r0seuYgAf0X6joAKUGuO3pXRHz6zqAGXQbr0AEv7fi7nyS7OGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761526002; c=relaxed/simple;
	bh=Cpu3tNq5t5MRPJ5n31jRC2+72eyCATFyOlAjGP1Myhw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OALpnqwpmyexty2mwIVHER16p6lqHPo0vpKyNgQNGVnw2ED+XxNwOJfdKAM/0OpRR7CO6tcPXWa/qmm50QxeGA+FM7XhNcFxNd3jWhYwsl37Gb/vlkZqtIJmzFZI0sB/pumDi/GmQaA6/HVW478LpuG6zmyViOIjv1fyyft50vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=esYp3PsS; arc=fail smtp.client-ip=40.107.74.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNRTIbKkxQznyExu+Or5iO4LKkgMrilK/a3jqFi0TH8Xzegk9KWYDe69qqLvlI7gtlV9Lrewn0e1QcvhKEd8yQm6Bdtf2OZhXtaJmPRr+oryK25KI8KlVXD0d/SSk4tfIO8c9VrVt/p1Z6D3lZS8bFX+asV+ErDUIAX0AQwztYwl8/1zu3Al5CZSuBquIUqtLxV7Q71xJb6/gJZawaI+c3798I9HA1JSw0q5xh8CazP4/t6YRoV6tG0SpnKQQ+6LztFUOsZoEwFlsfKov8UA4AxEwtKAuJZ/M4SyE3oQUaCgzbuQg9ZawBGR7ebqifVFieRYHduD45t8ZsBVE9E1nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85cwlf0+qj5XCDapj5UtjS1p0vGUXiN2ZkFLDAWFDoM=;
 b=HSzb3fmFiHxPcBC7fIHfWuXxYId0apWdoxPI4J8ddBfCd+hvu8AM4nh4JpddyMtwTI6NsShDuUMjEwiCO2xljt6zSDrQs2on3Ov7f89+H9BXIsyMI4vQjC/ZLl/jzdd4qP2Nzt73dek6St9YeMrgH5sbnhj94wmPy8ThBJ0N8tikESngiM139GhBPG1kHEUXpBl+tKUZ1y9aKK+y8H4XkSgG9vbDQPnUUWjqTxCGY8BfvW1bLDbkyaARteH+haYEJ3YNpJACYUjhu5u94O0w89nE5V/RX+Y1XCwIjwP4EYFwis5Sa0k1itBgImMSi0Ve6WFvtJvd0rkLpir6W3UoyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85cwlf0+qj5XCDapj5UtjS1p0vGUXiN2ZkFLDAWFDoM=;
 b=esYp3PsSUHgch1fLnlacD9xxLSie/i42U/9rBazqHDUo44YfTUmCwWhCfUo3pCvYrmLOFEkm0Xn30X27hAvQVDDWKoXBgKae2PoEYaY6iz1919nBX96daXftgzGh1v5kV1BrLKfpu6qUktA7VyF7JBEOwh5ALOZv/8SLVoU6h+Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by OSCP286MB4695.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:323::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 00:46:38 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 00:46:38 +0000
From: Koichiro Den <den@valinux.co.jp>
To: dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: vkoul@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	kuninori.morimoto.gx@renesas.com
Subject: [PATCH] dmaengine: sh: rcar-dmac: Add missing dma_descriptor_unmap()
Date: Mon, 27 Oct 2025 09:46:34 +0900
Message-ID: <20251027004634.562749-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0022.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2b1::14) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|OSCP286MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6ecc30-ca51-4104-8d8a-08de14f24958
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yvhf39BxsMJJDAWL/vdKyEgUwNWOH0QL295a0JcTR3VZjiCUHXB6TYz42Jt5?=
 =?us-ascii?Q?G72Tklvmo4rcK1it7ZhaxqFzUmZzS0dz3GWqksX1Nk8YJFDfksF3rCEXfF42?=
 =?us-ascii?Q?rC1+r90acZOMlWD/9o+q7/FfZXg2G0b72C1vhYN2ExXJ7Ice2hKdxUmUYJq+?=
 =?us-ascii?Q?w80hObOJDkWmSTDhl51BylX2crIpJPHUbVmSYJRvD3ymSSf39RXsSyhhs4Zl?=
 =?us-ascii?Q?GL3022f1393LJj+WQsFDTwPzFlChvOrBzW+pL4sunMPTxN1teyAbUkAeJzii?=
 =?us-ascii?Q?EU1l/g2Oi2ORzuhckH3XhodqHj+GGiHbNCIApNW4C5Zsn6F4x7Rm4kgXD1hh?=
 =?us-ascii?Q?W3I3xOvwgGehs5FnkkI5IN8UD3xtepEqAY90wmu0J5a0GaDNEG0Y/Ikkclbz?=
 =?us-ascii?Q?pzhfneiUxrbi1PFAPrfFH3+1TyaC93JAArl1GP9nbhLEF6NBxN+tFvkRhy0S?=
 =?us-ascii?Q?t7DvBvd+YQJtOdpbi0sfw92ealxY7EXNDOGV6uXit7LdACtfN6fhhmb0oT37?=
 =?us-ascii?Q?2XK65EnapuhegTSr64ti7gOZTjnPP1SMkTNmJQ20hmx1xHyp5AG3QKip++2s?=
 =?us-ascii?Q?SMwslRBx3Uh5sR62rPSH6U/9KW+uWgaiLCpIZqy6ryTSceuWub4cBkPXkIos?=
 =?us-ascii?Q?MxMX7Tlkl4KWEfzmLacvE1+ryl+EsDyd4Rb0HbMwDGEqRCe3FwoUv0Vpz/LQ?=
 =?us-ascii?Q?x5OLdgKtWZyp2orfzq47/8zK2+a8Mu7PLtl5YUs8OUF/Nr3BrHPDsoZ9uYpd?=
 =?us-ascii?Q?ZVqon108Yq4V8yIeXP7JOkv66VNwlivx6YffFylrbuQ6RoqJlWHttzPfw0q8?=
 =?us-ascii?Q?hT4IreEcAsgrzjrJIM3HC63vgGPTeO31O7xcdmh29K0VnWBWBfHgEwIwm5Jl?=
 =?us-ascii?Q?dxGpENrpuTPqF4WDRae+3cfh7yGmFARV0iHJnp+sQS7RJ8MuO4OJp4c9VXTf?=
 =?us-ascii?Q?sKXUxoRSHK36wIwWrO2kjXKa+75e5CWuR83Hct7SwtvLO5ephk75PoAV/PCF?=
 =?us-ascii?Q?fHXB5d7H4mz+QQzo0AaObOg4iuodA62k6wCdcwHQY6La87iqA4+QhFWt0YNF?=
 =?us-ascii?Q?afvuCEng6QQD0zz4rgEZbOqY7Nkk4eUxltZ3ayXGui6kVhqpFfobFNvbjz6w?=
 =?us-ascii?Q?IAAUScQMoby0AWAa6Vz3/DcB6zl2+rz8uKEiv6DgXeDYUOa2P/VumblKHFzK?=
 =?us-ascii?Q?4kJnDZOgSRfr5sMdiWJVhNSwRasd1ds51zSjtzpf5+UJeC35JevBuTJQAqWk?=
 =?us-ascii?Q?lC+C2lBlkVL3OjE+AhtwSfvW2djH6YEvxR4M0JIyaLxcKA4J7KgWmuQP9Nyu?=
 =?us-ascii?Q?uwUPp5f7GadvX5kxKozY+r1CzJnd095rhsfJGoLdOry6Oil5IRY732vziQd2?=
 =?us-ascii?Q?Xe67C8sofsmoNzGmQNJE190xIGmptsZRMDeehlBbotAhEkw+b8oM4VUR94nn?=
 =?us-ascii?Q?rBnWd3DH/s05Eo/OvU8UIXOy36aXAAcs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?maJc+djuLP8o7eQnjT3uJbOVlNwCGa++PQddH6Jt2dbkEiSeX7o3hGx3OlSs?=
 =?us-ascii?Q?lq7+3u2vxGExPdwtXExVLTWkRQ3dDdOXnRMxzG83EAWqrahyMYyHKm8YToP6?=
 =?us-ascii?Q?aF/Sh8ihbx44awd2/AqeJ5ClrVO5XgY3QX1hmRsTw8PMPkUnszMiF/LME+/v?=
 =?us-ascii?Q?SL6iGNMlKvNPBZ5HZoGtqxAPWjq31JHt1awRKREgWCkWuIX8YA1MDHh1e4om?=
 =?us-ascii?Q?uXYSfH0dPWNJsnCatOisCAON3UHf7S3i68dkExI9SejIpIe0LxoIar10iQZB?=
 =?us-ascii?Q?aCI++/5zpKGQ7AnLKCYHTWEjnYJ2iAbyktvD+Vd+ufyOeCJaWjIriZmuzPah?=
 =?us-ascii?Q?djb8hnC4OFOqUrNryHUIATaz/QGqK0l9fxTjkxmjFJ82F/Fz/I1eXgnuNyFN?=
 =?us-ascii?Q?KTwwzQLcxErVOKljSaBVpPR0a5PqC8sJcCKhNC4OxSWRoB4VS6yOh+7IDluc?=
 =?us-ascii?Q?osFfyKHjo3GAUE4sGNnJoXQFmR+7p3vuuBeFPAiw8zjyoOVwfm2YaY2f/JZ2?=
 =?us-ascii?Q?DBadZaRJHL7mbhZf5cy28TfyQDRTzcJCUwnL6MjPF/l4kbnePykFjT8P3RRR?=
 =?us-ascii?Q?5iwV1FQX15Yb16BNnLBJUtTyUr4d6GM/HMJ0MgUgTzSj/TWffkFjbpb7hpP5?=
 =?us-ascii?Q?Jfsr77cESsbClL4ex5O5LxkQER2OR2DlHH8FFcah1CFJMUip+8u8Ctvb0+ij?=
 =?us-ascii?Q?fP+ROPtOmuK2Qef7kjSreFRNoOmadOIpynqWOPQ4TFbz0kLo/T8bvtc/1bGz?=
 =?us-ascii?Q?o8QDTqbYTSDcHdtj5fohSCbAuzf/1lHQxNBE5EJxsjc97a0uJ4L5+KWU7YLQ?=
 =?us-ascii?Q?kc63YqJ5UUZhMhZYdffwfWr7OiqLEkGLARw8bVmU2OswhupDXj7vN9EMm3ed?=
 =?us-ascii?Q?o+jXZirjUrkHH+FnWnjVeRwkB0njSw0z2/GGoxjRVcLAElz+SCrR/c4gMvcN?=
 =?us-ascii?Q?kleWB+n/kv1ftE2vb6B+321rcc33bs7mqmeKEPMb930tgbAHQVJjiz3yeG8I?=
 =?us-ascii?Q?Kh1WULER3hVHoNe9GsbrQ/yTD1LizwAgSLKbjwhXzPYlPhqxS/zgPr3eumV7?=
 =?us-ascii?Q?+ZD720sMp6wkVMOFl9hRmj1oMfZBYG63lA/fXQlnuQAYGzdHylB/+qeHOhMI?=
 =?us-ascii?Q?EJi7edBW0HpYXENmhFfdlDQWfWdKaXz5CB3VP4e5BEBY+4YgwegG42o8qEXO?=
 =?us-ascii?Q?YJIGzznTXF14l1nXQMIg4jVZdaDCOU9VOig6ESppmSDDby+jFouJ7HFJcvlU?=
 =?us-ascii?Q?nAb+NfAIEPCZNFkQW+wdWZoBMLm8n2VWvI+lstfUta9OFltY3eRW79gTuCOs?=
 =?us-ascii?Q?JfPm0tbXz2gITrfhy9ckqSiuEwR6PmCU2NoPwG+QGjEorjsaBMbwW7Y4Yg/4?=
 =?us-ascii?Q?xedEoofagdceROZjjF8FQvnx4jBO2B7HqiObMeJMW4lEl4HCwdIjP1ZZACdo?=
 =?us-ascii?Q?aYipyvma6/uOfT8sw/N1ovwu0FCisuK81+eY+DhXPBlgQIedbxXCagZv4bsl?=
 =?us-ascii?Q?G6ZtkqGN9W0GQXnn5NuzrRh9JaKeE68B1vX7p0IzHAp/jg7T0G+BPL8ax8u5?=
 =?us-ascii?Q?PJuZteEgu/cCc4g53utOOnHqk1dGO8c7WSFGmwzSY5Up54f6nimIXoVRMM3O?=
 =?us-ascii?Q?vJSQD3UaRbKFHnAI9DEu3pU=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6ecc30-ca51-4104-8d8a-08de14f24958
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 00:46:38.1752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kO/AR58qOgmCDjGU+qDX7Y+i6C1I/cCoVtrdvQtZ5GjEN3KIUrTtwEoCRG9HzAwX35DTheH3cRxzvhHMeQ5q+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCP286MB4695

Call dma_descriptor_unmap() right after dma_cookie_complete() in the
threaded IRQ completion path. Without this, streaming DMA mappings
attached to the descriptor are never released and may eventually exhaust
DMA mapping resources (e.g. IOVA with an IOMMU or bounce-buffer slots
with SWIOTLB), leading to dma_map_* failures.

Also ensure dma_descriptor_unmap() is called in rcar_dmac_chan_reinit()
(error/terminate path) to avoid the same type of leaks.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/sh/rcar-dmac.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
index 0c45ce8c74aa..c30f64180d9f 100644
--- a/drivers/dma/sh/rcar-dmac.c
+++ b/drivers/dma/sh/rcar-dmac.c
@@ -842,6 +842,7 @@ static void rcar_dmac_chan_reinit(struct rcar_dmac_chan *chan)
 
 	list_for_each_entry_safe(desc, _desc, &descs, node) {
 		list_del(&desc->node);
+		dma_descriptor_unmap(&desc->async_tx);
 		rcar_dmac_desc_put(chan, desc);
 	}
 }
@@ -1652,6 +1653,7 @@ static irqreturn_t rcar_dmac_isr_channel_thread(int irq, void *dev)
 		desc = list_first_entry(&chan->desc.done, struct rcar_dmac_desc,
 					node);
 		dma_cookie_complete(&desc->async_tx);
+		dma_descriptor_unmap(&desc->async_tx);
 		list_del(&desc->node);
 
 		dmaengine_desc_get_callback(&desc->async_tx, &cb);
-- 
2.48.1


