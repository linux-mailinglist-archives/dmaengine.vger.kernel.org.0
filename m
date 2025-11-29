Return-Path: <dmaengine+bounces-7387-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 846D4C941F6
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C41EB4E2C69
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63A2309EF9;
	Sat, 29 Nov 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qQKHo0BC"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011006.outbound.protection.outlook.com [52.101.125.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F45F222587;
	Sat, 29 Nov 2025 16:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432267; cv=fail; b=uNKxpFVgMLISsGDHNdsqCNBIPWW+2cGkJcDzWNyz1H45peyKGY/LDTaBXuuNy2YjMzL2EV88d7u8TCoRrV7WaJAjdnhxIm4ffddOe7oWD7uJS5MiZfChCCerG2UGrRu8DnM06p/HH6xRHe0vMcKuiFN9E8Fc1i/Kru4mpkr+6II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432267; c=relaxed/simple;
	bh=dvuM9c1KmtbMygEBKksYHiXLDcJCaaaUnlXiiYZfuWY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bqJZl7MAg6RK6vc9t5q30tV9ltkuQS2aWAby2URLoG68Pjv0AqaSt4DRZDI+5wKwNwgeahBB8HxRiSXbNT1EpAeFe6Ni90X8ZbhvNS0aWT88iaikAqmGaIvGt2kd3o9obh32wm6cSRU8oGrjHMPdj59FfsfGOXOYJCFCYjhO1Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qQKHo0BC; arc=fail smtp.client-ip=52.101.125.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=grWvrgOlUuB5GarSxSoJet3twIFfKwtLRMEEx3VVaWKCss0zFrgfT8dlJ1/Tmj6XRWvHZ2EiD5Hw8PYRnXqyhWVDU4qurc0jwFyrxyfmuSZSektKsPTkRW2a9vIEq8pnxyCgiLBK50TMVl/Z0K1v8Nf6lbgDSF6GUjqjpS35s5mYBiLR2rlTpA8O2C4GySM8iUkqsCyHpeGxXSjKd8snI3Kqo+dTmTqo4b6dAJ3Ml3eDVVf5EWKpOVIqify9Ov+J/xl3DeNRRsWR9RrsFW/D8HIGxhPiRHSMdseqCEuEhcNufjrK2NMIEGKCWlf00Haf7FKSj3r0YuNxi2EU8Vih6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qpr/7aCPVeeJZ7vdg6rz5py9FXI+c9rVhrJZdjMMVs=;
 b=vtbn+Bci/82UzDWo8Tj+L/kCjGHWB8Fd+WJ5pqu+kKCHuGbj5N7O2xQoOiDdz1/GbLdxaQNpPlKGhiGokY3H7tZfl4k0eYoj+Bn8KXtHe6VQ+ealvEzdi/aL/xXEZNVg9FkXpWdtWp9vGm2QWFWXSjrqUcvcy2f6j5rrINC/8Wke4uGjY7aPjo/Z+D7bX4G0UXOh3w+YwPI3uE/I8k8+VfL2uctdDd7bvKKNavokdjxTKXK5JUKDIGpVOM6Xi7Ix8yUTr2OnIxfcQiDZs3qClGemf51PV6ptk5MRZviW9ZAJPRLVbCHm0i3bS/GRh8BHNb5XCx3dbU2ZPokwIciphA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qpr/7aCPVeeJZ7vdg6rz5py9FXI+c9rVhrJZdjMMVs=;
 b=qQKHo0BClGXJxM7LL06lwSEeeBVLRG5n6nR88H1ZuRHv2VJZ2yzQUGoyaXF94XKZ0TYtJGzQPUzKKmB30dr6F+YjiXcc0B5i+BRFreX866gYC7PTktYGk8F4SFnkICaoQQL+6tSebBHAa6M0LYdnVNbm4nRNyF0HSxchjwI/ySg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:19 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:17 +0000
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
Subject: [RFC PATCH v2 00/27] NTB transport backed by remote DW eDMA
Date: Sun, 30 Nov 2025 01:03:38 +0900
Message-ID: <20251129160405.2568284-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0228.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::7) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a4cf1c0-f523-4324-e57f-08de2f60f32a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1rkTTLHwT1IU7dQHGdZC1zk/TXdwHu3Anv2vxDI5Hv6O9bJSY6WUdrnkcHGF?=
 =?us-ascii?Q?3JU+ESdldGxwO9Wlh8AKwIf46BwTytT9BL1qLKPTPnNY0URPER8dBoAcBhYE?=
 =?us-ascii?Q?pQQBlCfSEH+3iocKC2y4SHLQdWUkv0AGGBtX0j0fPD4E5/HqmjHpaoiZNFjm?=
 =?us-ascii?Q?Rdx4Djyt0Sf9Qh07P3X9I8qgU5Mb88vMlpyw1hWRnQyft/CU10rdfv3OSlTu?=
 =?us-ascii?Q?yAtBeOWfZ3LKKZII27SE/YvlE8rCDdbQ1QG5bETAI74LuUFCSFnVeGKdBgKF?=
 =?us-ascii?Q?1YbOkuMVuVw1JBa+VFZ+p32/BjCoDitN9//Z9S8uJgTZ+2dNaplh9Bv/CCiM?=
 =?us-ascii?Q?eNJgVubAdIx56MjlRapEwC7k1vwbt/E6AAAGttYB8dkbO5ym7joXO2UNtnnf?=
 =?us-ascii?Q?bzuBUWSNh/vxhNJzoshC3KN5DsgZ/tCGhftd9S8m6t5E9T9ispvcD6ds5sdv?=
 =?us-ascii?Q?p9McdkQKlAKko3usr45WR3NAqkrU0WOhbBIVMcYoOGgafw1Z9a3OLa7bijB2?=
 =?us-ascii?Q?ogsiAkEAbNkQTpru9yCE3Hux3Xb91ztVneP59enu3fdKASJIp5uxlRSfsS3l?=
 =?us-ascii?Q?qJuyj0iLDA8L/xTE7pjbOKBJK+Celm8tNWB4TMG05VojBHu4KUv2c2t65OZC?=
 =?us-ascii?Q?HjvP0O27lchqKGj0rp1wdZl79ZIC5+Vn+QIMPM6Y0HLdgb3TJmR8vj9dMwOF?=
 =?us-ascii?Q?+A8pAeXazRX95xwsxt6ZE43CJu8uf9tXVnkkoAZWA3wUH7+UoNL6eA7xR4dd?=
 =?us-ascii?Q?FJvF8w+TnaJDwfQ8Q8stCUJE5f779VDucbeJfCACDfupzAko7b/2TA3P92+v?=
 =?us-ascii?Q?BZ6rpYmomVafN1P4bXuLTtB4hMQQGNCj6InkF61v/HR1rCRT4OUE0hMDrbz/?=
 =?us-ascii?Q?i3asCmL3AoTJrMJrHXhGSKR0pg51IltPxZPvNQwV3bHq1G0dkVZ5gxd8TaAJ?=
 =?us-ascii?Q?bErOxsxSE0rSorvsR/EcQh9pg+oIaimB1qkWaop+Gfh/UFXhatkRE4HzsjJL?=
 =?us-ascii?Q?FWLcQf9+yHfRJ0f1XghsgI7D5ifH1T1RHLUBpB7xkFPyIB9n+dF2F+nKSPVP?=
 =?us-ascii?Q?+8FALN0IBaqdeLQIPueZaiZNX7GgufCCJjjNW3DJ/k++FTfAS0NBTHOWWXAH?=
 =?us-ascii?Q?IptcnzQec+kyORKJFwpOsOkmh9j+hzfp1b3DHQSo1vmNPezb4dm0/Eb9wJAT?=
 =?us-ascii?Q?JVa0SD0pmhkabcxqentgQB7y7Gu2Pw5SdsQFm4K3DoGTrXlBtuu9wzXz5S0c?=
 =?us-ascii?Q?lG/gC7k5wAfIrIOY8FdqhsTM05Qlj95Ylu50IMDkCkN9lkgfEwl1aLMhei2a?=
 =?us-ascii?Q?fJ7MUaAFdQCtdCTGGgTb/bsIchpZ9eQiJi77MMsU25jTUtUmiVu74ykXzCrp?=
 =?us-ascii?Q?ixdRP2aqP6Gp4ttGpbe/DvnmIAzm0nnk6MqNesfq2xMPrAYSghkTD4LxtZ3o?=
 =?us-ascii?Q?8F4eTC0rN2iJFMdSKKGXYm0JvD5P287K?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UYUO6va9t6GZEuF6Q+hK/oGK4UtSLr9yDy4F/jT282aq02M5FanOkSoMxI8D?=
 =?us-ascii?Q?ogPmB73LTOrU7M4mwytxwlJAyiq19T2YdI7HXL2l132Qm7uQw6xGty9YQR5E?=
 =?us-ascii?Q?d19QXoHw01L+yY5NrVIfkpFPvAQqFg69cJS3iTsjNuF+RVVn8ux3HVGRA4Df?=
 =?us-ascii?Q?nq85IQCw31A8HW4LgfgyJsIbsmYJRSldoTtgdjcB5cCMtbdHsw50gnzWEmeg?=
 =?us-ascii?Q?pAslGqHNGD6tKknoTdzpxUgpCJpnZj/Zi5QtxQjuc9kLOOhXozdt0blXAGIA?=
 =?us-ascii?Q?EyXKFgqMBqZBQqhC+4qWcYm9iLqmzFRSBufhqy7sStPaJKRx1Mli/Cmk4NY5?=
 =?us-ascii?Q?7dAo4d8sj66Ey4Jj8KoY2MwzlZI66SXrRIWz1SIUnF0MBweJkjslc++mq52L?=
 =?us-ascii?Q?hVEMMNTZ9NTFnMgpAT6ceb6LlLbAu280U6lN0ym7nDtHq5GhZFkXfnu0e+LK?=
 =?us-ascii?Q?nS8uM+znVc1Ey4Edg0C+F5DeK4dbKvv7HnBBH76oNgvE2a7AatY32K79VA94?=
 =?us-ascii?Q?hqgPZDZ0SV7cA7A+zhtkfciavICkyBdtxxPa/VkPrJccXEP97GnzTRLpOclH?=
 =?us-ascii?Q?dAXtkeBiV85P7NJxb636wLhFcqab7DKy9k8fgqSh/mBvO+4a4GCWhfkdAUM6?=
 =?us-ascii?Q?0SY5kYgWHokEmg7IFkDqqIDIJsMrzYGM89W1MqDiTrjV/c01XhiUYyCJ5chw?=
 =?us-ascii?Q?qOI++pmn/MK4Z3FHL97QI+AxCb2UkJIzSWesBzRjwfznvMdN+vhylm4V794d?=
 =?us-ascii?Q?WXD0qSp3/nbxGxInXpp969vPgsmsMUhfkjS0cYmeRk1sZySm5tbW/QssvWCi?=
 =?us-ascii?Q?Wrc1Qb+NhodkKbBMdAmRqxihyPGpFgNL7w21W9h+CmeNZETJ2Nzs9rP00CQl?=
 =?us-ascii?Q?8uZTa+W37UpZ3fbak901/MkFp4iXLObjFc+JkXUM34/fF7d8TmpgSoORcdJV?=
 =?us-ascii?Q?kclUOnnrqjxWFL6/hf5uEpfYlhCQdb5pBcl8vH45klF65KOhEYkUX3jbkkI0?=
 =?us-ascii?Q?R9NGn4PWLUOWXfLFCiOUXPF811GavW9tot8X8WkUqQFRhGeC60oEUISEwI4i?=
 =?us-ascii?Q?PmCxJUvCji3ZvxqLML7MX9DiTlYTDU53yh+QoEKOgVTMhb7QNLFEhazeIUpy?=
 =?us-ascii?Q?vPHIm/7hhWhdTA7J9xGnXcI7anUhJHCdhFd6dikHLeAZ37fOJ+gm/q0ioXM/?=
 =?us-ascii?Q?7tAkv0ardECPQiWJTswVmCVK8lXH0Co9LOfI4B3/+9L6/NnNsrN6NLAkToZ4?=
 =?us-ascii?Q?JHnnAUISZbIRkWqJuFQ7s6hbi+SQE2l8rPhmGOhx4PqmKGXdiiN9Ash52gfc?=
 =?us-ascii?Q?lAH4rxEB321Lz3wsWXdPHtnTKOotl6opQ+ivOnmnS6LUIXJOWchVeMTZ+fx7?=
 =?us-ascii?Q?/Pauu6SL4ZrYra3zigpIz3wOq/WNMkzSIB3NZTCE5+VKFAmCs4/9+b1ZCZnr?=
 =?us-ascii?Q?4Zj/x8GD0Hbxov8C+C9EJLLe+2bjrSPbEtuHevnpoQEuXrfw+/WPipRfoGLs?=
 =?us-ascii?Q?BAoQDd+XedGenaefvkDXHEVXyqnzziJG7lTCQPseBGwhKAVqX7SndbeySoVN?=
 =?us-ascii?Q?qZGLv/4f0q9qsVzciYVsQVJzwuXVGzq3Cehz/c5ubFTG78dOs5MHMmJ/yJN7?=
 =?us-ascii?Q?ieyPQwNlcg5fUSxgas5x7yI=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4cf1c0-f523-4324-e57f-08de2f60f32a
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:17.7810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SnVom0hn1Od2ANPQ2J7ArRRdclH4NGvWOL3mafcEQZTkT7QpM4QzH0g9I6jWbLPy9sZeYE8opmKFLW3xg4GVww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

Hi,

This is RFC v2 of the NTB/PCI series for Renesas R-Car S4. The ultimate
goal is unchanged, i.e. to improve performance between RC and EP
(with vNTB) over ntb_transport, but the approach has changed drastically.
Based on the feedback from Frank Li in the v1 thread, in particular:
https://lore.kernel.org/all/aQEsip3TsPn4LJY9@lizhi-Precision-Tower-5810/
this RFC v2 instead builds an NTB transport backed by remote eDMA
architecture and reshapes the series around it. The RC->EP interruption
is now achieved using a dedicated eDMA read channel, so the somewhat
"hack"-ish approach in RFC v1 is no longer needed.

Compared to RFC v1, this v2 series enables NTB transport backed by
remote DW eDMA, so the current ntb_transport handling of Memory Window
is no longer needed, and direct DMA transfers between EP and RC are
used.

I realize this is quite a large series. Sorry for the volume, but for
the RFC stage I believe presenting the full picture in a single set
helps with reviewing the overall architecture. Once the direction is
agreed, I will respin it split by subsystem and topic.


The new architecture
====================

In the new architecture the endpoint exposes a small memory window that
contains the unrolled DesignWare eDMA register block plus a per-channel
control structure and linked-list rings. The endpoint allocates these in
its own memory, then maps them into a peer MW via an inbound iATU
region. The host maps the peer MW, configures a dw-edma engine to use
the remote rings. The data plane flow is depicted as below (Figure 1 and
Figure 2).

With this design, per-queue PCI memory usage is reduced to control-plane
metadata (ring descriptors and indices). Data buffers live in system
memory and are transferred by the remote eDMA, so even relatively small
BAR windows can theoritically scale to multiple ntb_transport queue
pairs, and it no longer requires the DMA_MEMCPY operation. This series
also adds ntb_netdev multiple queues support to demonstrate performance
improvement.

The shared-memory ntb_transport backend remains the default. The remote
eDMA mode is compile-time and run-time selectable via
CONFIG_NTB_TRANSPORT_EDMA and the new 'use_remote_edma' module
parameter, and existing users that do not enable it should see no
behavioural change apart from the BAR subrange support described below.


    Figure 1. RC->EP traffic via ntb_netdev+ntb_transport
                     backed by Remote eDMA

          EP                                   RC
       phys addr                            phys addr  
         space                                space 
          +-+                                  +-+
          | |                                  | |
          | |                ||                | |
          +-+-----.          ||                | |
 EDMA REG | |      \    [A]  ||                | |
          +-+----.  '---+-+  ||                | |
          | |     \     | |<---------[0-a]----------
          +-+-----------| |<----------[2]----------.
  EDMA LL | |           | |  ||                | | :
          | |           | |  ||                | | :
          +-+-----------+-+  ||  [B]           | | :
          | |                ||  ++            | | :
       ---------[0-b]----------->||----------------'
          | |            ++  ||  ||            | |
          | |            ||  ||  ++            | |
          | |            ||<----------[4]-----------
          | |            ++  ||                | |
          | |           [C]  ||                | |
       .--|#|<------------------------[3]------|#|<-.
       :  |#|                ||                |#|  :
      [5] | |                ||                | | [1]
       :  | |                ||                | |  :
       '->|#|                                  |#|--'
          |#|                                  |#|
          | |                                  | |


      0-a. configure Remote eDMA
      0-b. DMA-map and produce DAR
      1.   memcpy while building skb in ntb_netdev case
      2.   consume DAR, DMA-map SAR and kick DMA read transfer
      3.   DMA read transfer (initiated by RC remotely)
      4.   consume (commit)
      5.   memcpy to application side

      [A]: MemoryWindow that aggregates eDMA regs and LL.
           IB iATU translations (Address Match Mode).
      [B]: Control plane ring buffer (for "produce")
      [C]: Control plane ring buffer (for "consume")


    Figure 2. EP->RC traffic via ntb_netdev+ntb_transport
                     backed by Remote eDMA

          EP                                   RC
       phys addr                            phys addr  
         space                                space 
          +-+                                  +-+
          | |                                  | |
          | |                ||                | |
          +-+-----.          ||                | |
 EDMA REG | |      \    [A]  ||                | |
          +-+----.  '---+-+  ||                | |
          | |     \     | |<----------[0]-----------
          +-+-----------| |<----------[3]----------.
  EDMA LL | |           | |  ||                | | :
          | |           | |  ||                | | :
          +-+-----------+-+  ||  [B]           | | :
          | |                ||  ++            | | :
       -----------[2]----------->||----------------'
          | |            ++  ||  ||            | |
          | |            ||  ||  ++            | |
          | |            ||<----------[5]-----------
          | |            ++  ||                | |
          | |           [C]  ||                | |
       .->|#|--------[4]---------------------->|#|--.
       :  |#|                ||                |#|  :
      [1] | |                ||                | | [6]
       :  | |                ||                | |  :
       '--|#|                                  |#|<-'
          |#|                                  |#|
          | |                                  | |


      0-a. configure Remote eDMA
      1.   memcpy while building skb in ntb_netdev case
      2.   DMA-map SAR and "produce"
      3.   consume SAR, DMA-map DAR and kick DMA write transfer
      4.   DMA write transfer (initiated by RC remotely)
      5.   consume (commit)
      6.   memcpy to application side

      [A]: MemoryWindow that aggregates eDMA regs and LL.
           IB iATU translations (Address Match Mode).
      [B]: Control plane ring buffer (for "produce")
      [C]: Control plane ring buffer (for "consume")


Patch layout
============

  Patch 01-19 : preparation for Patch 20
                - 01-10: support multiple MWs in a BAR
                - 11-19: other misc preparations
  Patch 20    : main and most important patch, adds remote eDMA support
  Patch 21-22 : multi-queue use, thanks to the remote eDMA, performance
                scales
  Patch 23-27 : handle several SoC-specific issues so that remote eDMA
                mode ntb_transport works on R-Car S4


Changelog
=========

RFCv1->RFCv2 changes:
  - Architecture
    - Drop the generic interrupt backend + DW eDMA test-interrupt backend
      approach and instead adopt the remote eDMA-backed ntb_transport mode
      proposed by Frank Li. The BAR-sharing / mwN_offset / inbound
      mapping (Address Match Mode) infrastructure from RFC v1 is largely
      kept, with only minor refinements and code motion where necessary
      to fit the new transport-mode design.
  - For Patch 01
    - Rework the array_index_nospec() conversion to address review
      comments on "[RFC PATCH 01/25]".

RFCv1: https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/


Tested on
=========

* 2x Renesas R-Car S4 Spider (RC<->EP connected with OcuLink cable)
* Kernel base: next-20251128


Performance measurement
=======================

No serious measurements yet, because:
  * For "before the change", even use_dma/use_msi does not work on the
    upstream kernel unless we apply some patches for R-Car S4. With some
    unmerged patch series I had posted earlier, it was observed that we
    can achieve about 7 Gbps for the RC->EP direction. Pure upstream
    kernel can achieve around 500 Mbps though.
  * For "after the change", measurements are not mature because this
    RFC v2 patch series is not yet performance-optimized at this stage.
    Also, somewhat unstable behaviour remains around ntb_edma_isr().

Here are the rough measurements showing the achievable performance on
the R-Car S4:

- Before this change:

  * ping
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=12.3 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=6.58 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=1.26 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=7.43 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.39 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=7.38 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=1.42 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=7.41 ms

  * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 2`)
    [ ID] Interval           Transfer     Bitrate         Jitter    Lost/Total Datagrams
    [  5]   0.00-10.01  sec   344 MBytes   288 Mbits/sec  3.483 ms  51/5555 (0.92%)  receiver
    [  6]   0.00-10.01  sec   342 MBytes   287 Mbits/sec  3.814 ms  38/5517 (0.69%)  receiver
    [SUM]   0.00-10.01  sec   686 MBytes   575 Mbits/sec  3.648 ms  89/11072 (0.8%)  receiver

  * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 2`)
    [  5]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  3.164 ms  390/5731 (6.8%)  receiver
    [  6]   0.00-10.03  sec   334 MBytes   279 Mbits/sec  2.416 ms  396/5741 (6.9%)  receiver
    [SUM]   0.00-10.03  sec   667 MBytes   558 Mbits/sec  2.790 ms  786/11472 (6.9%)  receiver

    Note: with `-P 2`, the best total bitrate (receiver side) was achieved.

- After this change (use_remote_edma=1) [1]:

  * ping
    64 bytes from 10.0.0.11: icmp_seq=1 ttl=64 time=1.48 ms
    64 bytes from 10.0.0.11: icmp_seq=2 ttl=64 time=1.03 ms
    64 bytes from 10.0.0.11: icmp_seq=3 ttl=64 time=0.931 ms
    64 bytes from 10.0.0.11: icmp_seq=4 ttl=64 time=0.910 ms
    64 bytes from 10.0.0.11: icmp_seq=5 ttl=64 time=1.07 ms
    64 bytes from 10.0.0.11: icmp_seq=6 ttl=64 time=0.986 ms
    64 bytes from 10.0.0.11: icmp_seq=7 ttl=64 time=0.910 ms
    64 bytes from 10.0.0.11: icmp_seq=8 ttl=64 time=0.883 ms

  * RC->EP (`sudo iperf3 -ub0 -l 65480 -P 4`)
    [  5]   0.00-10.01  sec  3.54 GBytes  3.04 Gbits/sec  0.030 ms  0/58007 (0%)  receiver
    [  6]   0.00-10.01  sec  3.71 GBytes  3.19 Gbits/sec  0.453 ms  0/60909 (0%)  receiver
    [  9]   0.00-10.01  sec  3.85 GBytes  3.30 Gbits/sec  0.027 ms  0/63072 (0%)  receiver
    [ 11]   0.00-10.01  sec  3.26 GBytes  2.80 Gbits/sec  0.070 ms  1/53512 (0.0019%)  receiver
    [SUM]   0.00-10.01  sec  14.4 GBytes  12.3 Gbits/sec  0.145 ms  1/235500 (0.00042%)  receiver

  * EP->RC (`sudo iperf3 -ub0 -l 65480 -P 4`)
    [  5]   0.00-10.03  sec  3.40 GBytes  2.91 Gbits/sec  0.104 ms  15467/71208 (22%)  receiver
    [  6]   0.00-10.03  sec  3.08 GBytes  2.64 Gbits/sec  0.176 ms  12097/62609 (19%)  receiver
    [  9]   0.00-10.03  sec  3.38 GBytes  2.90 Gbits/sec  0.270 ms  17212/72710 (24%)  receiver
    [ 11]   0.00-10.03  sec  2.56 GBytes  2.19 Gbits/sec  0.200 ms  11193/53090 (21%)  receiver
    [SUM]   0.00-10.03  sec  12.4 GBytes  10.6 Gbits/sec  0.188 ms  55969/259617 (22%)  receiver

  [1] configfs settings:
      # modprobe pci_epf_vntb dyndbg=+pmf
      # cd /sys/kernel/config/pci_ep/
      # mkdir functions/pci_epf_vntb/func1
      # echo 0x1912 >   functions/pci_epf_vntb/func1/vendorid
      # echo 0x0030 >   functions/pci_epf_vntb/func1/deviceid
      # echo 32 >       functions/pci_epf_vntb/func1/msi_interrupts
      # echo 16 >       functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_count
      # echo 128 >      functions/pci_epf_vntb/func1/pci_epf_vntb.0/spad_count
      # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/num_mws
      # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1
      # echo 0x20000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2
      # echo 0xe0000 >  functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_offset
      # echo 0x1912 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_vid
      # echo 0x0030 >   functions/pci_epf_vntb/func1/pci_epf_vntb.0/vntb_pid
      # echo 0x10 >     functions/pci_epf_vntb/func1/pci_epf_vntb.0/vbus_number
      # echo 0 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/ctrl_bar
      # echo 4 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/db_bar
      # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw1_bar
      # echo 2 >        functions/pci_epf_vntb/func1/pci_epf_vntb.0/mw2_bar
      # ln -s controllers/e65d0000.pcie-ep functions/pci_epf_vntb/func1/primary/
      # echo 1 > controllers/e65d0000.pcie-ep/start


Thanks for taking a look.


Koichiro Den (27):
  PCI: endpoint: pci-epf-vntb: Use array_index_nospec() on mws_size[]
    access
  PCI: endpoint: pci-epf-vntb: Add mwN_offset configfs attributes
  NTB: epf: Handle mwN_offset for inbound MW regions
  PCI: endpoint: Add inbound mapping ops to EPC core
  PCI: dwc: ep: Implement EPC inbound mapping support
  PCI: endpoint: pci-epf-vntb: Use pci_epc_map_inbound() for MW mapping
  NTB: Add offset parameter to MW translation APIs
  PCI: endpoint: pci-epf-vntb: Propagate MW offset from configfs when
    present
  NTB: ntb_transport: Support offsetted partial memory windows
  NTB: core: Add .get_pci_epc() to ntb_dev_ops
  NTB: epf: vntb: Implement .get_pci_epc() callback
  damengine: dw-edma: Fix MSI data values for multi-vector IMWr
    interrupts
  NTB: ntb_transport: Use seq_file for QP stats debugfs
  NTB: ntb_transport: Move TX memory window setup into setup_qp_mw()
  NTB: ntb_transport: Dynamically determine qp count
  NTB: ntb_transport: Introduce get_dma_dev() helper
  NTB: epf: Reserve a subset of MSI vectors for non-NTB users
  NTB: ntb_transport: Introduce ntb_transport_backend_ops
  PCI: dwc: ep: Cache MSI outbound iATU mapping
  NTB: ntb_transport: Introduce remote eDMA backed transport mode
  NTB: epf: Provide db_vector_count/db_vector_mask callbacks
  ntb_netdev: Multi-queue support
  NTB: epf: Add per-SoC quirk to cap MRRS for DWC eDMA (128B for R-Car)
  iommu: ipmmu-vmsa: Add PCIe ch0 to devices_allowlist
  iommu: ipmmu-vmsa: Add support for reserved regions
  arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe
    eDMA
  NTB: epf: Add an additional memory window (MW2) barno mapping on
    Renesas R-Car

 arch/arm64/boot/dts/renesas/Makefile          |    2 +
 .../boot/dts/renesas/r8a779f0-spider-ep.dts   |   46 +
 .../boot/dts/renesas/r8a779f0-spider-rc.dts   |   52 +
 drivers/dma/dw-edma/dw-edma-core.c            |   28 +-
 drivers/iommu/ipmmu-vmsa.c                    |    7 +-
 drivers/net/ntb_netdev.c                      |  341 ++-
 drivers/ntb/Kconfig                           |   11 +
 drivers/ntb/Makefile                          |    3 +
 drivers/ntb/hw/amd/ntb_hw_amd.c               |    6 +-
 drivers/ntb/hw/epf/ntb_hw_epf.c               |  177 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c               |    3 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c            |    6 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.h            |    2 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.c            |    3 +-
 drivers/ntb/hw/intel/ntb_hw_gen4.c            |    6 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c        |    6 +-
 drivers/ntb/msi.c                             |    6 +-
 drivers/ntb/ntb_edma.c                        |  628 ++++++
 drivers/ntb/ntb_edma.h                        |  128 ++
 .../{ntb_transport.c => ntb_transport_core.c} | 1829 ++++++++++++++---
 drivers/ntb/test/ntb_perf.c                   |    4 +-
 drivers/ntb/test/ntb_tool.c                   |    6 +-
 .../pci/controller/dwc/pcie-designware-ep.c   |  287 ++-
 drivers/pci/controller/dwc/pcie-designware.h  |    7 +
 drivers/pci/endpoint/functions/pci-epf-vntb.c |  229 ++-
 drivers/pci/endpoint/pci-epc-core.c           |   44 +
 include/linux/ntb.h                           |   39 +-
 include/linux/ntb_transport.h                 |   21 +
 include/linux/pci-epc.h                       |   11 +
 29 files changed, 3415 insertions(+), 523 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
 create mode 100644 drivers/ntb/ntb_edma.c
 create mode 100644 drivers/ntb/ntb_edma.h
 rename drivers/ntb/{ntb_transport.c => ntb_transport_core.c} (59%)

-- 
2.48.1


