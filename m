Return-Path: <dmaengine+bounces-2367-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E535490940E
	for <lists+dmaengine@lfdr.de>; Sat, 15 Jun 2024 00:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B86A71C2114B
	for <lists+dmaengine@lfdr.de>; Fri, 14 Jun 2024 22:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370D1146A8E;
	Fri, 14 Jun 2024 22:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pz3SkGxa"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14891386B3;
	Fri, 14 Jun 2024 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718403370; cv=fail; b=FYnlDBvUPt05HGsWhZSFGMRRdUhm0r55srbWqwDSDAlRjQHr0aMxPazXSObTFxYACW9eLp8w+qUz2JAn/LuXvvA0fRGLk0ROy+r/eT5YkPiXM+hic8Bg7mqj4HuLy5ZHn+42tTiSJ70NZrpEfYr2hYes6SyiJGv7Tp1vOCbMqwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718403370; c=relaxed/simple;
	bh=4YoTyJ1dNljpyIdKuoFrMl76VapfA5NRM4vpZEyUm1A=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KQeHA3ji6BgITWKhzMPcOFr6P4Pkt5SN7Fs2CXK2TY3cqsjo/6cm532RqwuGpFYE/8KTuYZ0JB0vnAvxW4ndVobC6H0A9SfSzOxi7jl0PfvyvAVNPqdrqBYbzF0xHrE1NoGTnnDA4Z4Xvt+dHHe6n8xxDRf/eoW49wel0/DZ2wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pz3SkGxa; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e8aW2cs8P1GlQ+v+oW+9CKb1Hg6PADpb+sArs9AF6ewQ1fburEgJ5mxrCVZOx8xM8WtX6qkhSxyhN7HiGa4geiqUgKikeU/rVivbPoaXZbariUckTbGAmwORudnSqeHCTtUhjCL3R/6C9tQ6CRQ2jSg5TiALXqVr6wnAcs/Tod5knGPkxPqIaYjY5wGOMRNaR3OIcYLb5lNFhFEsKUlZGi7/59eq/bxfPGyvoFXxaZWCChozILJt7aWgV1GwiOfsn/AjavBzJV4Q9j4YizNUtzdEhZ+VeobOV0Ld3gIJxn+PpZ9/Z0z189zqA4rM3Gz8bqxbMCJ2KW8OtEy8M7d8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBS53lPSiNwKDCkeladM+K8A5G/lfzJEJoCY+IB2E2E=;
 b=eM268QdP8czvrQTIOQuuvWTb0KuEN3zdn0p+YGBYByqshCptWNZs1QaqZFY0nLdpZ4ZX7tPYr9PqpaJR+MeCEH42MzhHldA8upoe8qyZp3au7r09a8TDQeDXJF5b9OUArFS+4wqshxMo3ld8E6IFPIzC6ih6wh0zuWTJsgfl9+fDNT3J8/NSjJXS8HcTdeKKAD7Y3hC63Mav8zImuagMLyHI7VhKTjLVagAKi+KiMAvTtrflaRbxLxQZlV0EwN+icHWq5wCLxTOPqOGGls+7QDi8jMPdbq+n6aQgVX/5m5ZY2a5qUy0nk2JnuqQcsKwWiIrNSY7va/y0PtEYrSJTBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBS53lPSiNwKDCkeladM+K8A5G/lfzJEJoCY+IB2E2E=;
 b=pz3SkGxaYZQ+lwMb5Ul9diS8kQl9yIkH+qbrNOg0878G17gMaknzsshnFQDACYvJPkIzW8hDASjK6LaotOI7F0+6sSiJXhdG7NygTzScvhqVc2CM3i0mIJv4Vff7y4ynD79PsCA4lozEK1QaxUpMxDlFlEhuflb6jRXDW/FsyFw=
Received: from DS7PR05CA0052.namprd05.prod.outlook.com (2603:10b6:8:2f::30) by
 DS7PR12MB6358.namprd12.prod.outlook.com (2603:10b6:8:95::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.25; Fri, 14 Jun 2024 22:16:03 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::c8) by DS7PR05CA0052.outlook.office365.com
 (2603:10b6:8:2f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.21 via Frontend
 Transport; Fri, 14 Jun 2024 22:16:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 14 Jun 2024 22:16:03 +0000
Received: from BLR-L-SHIVAGAR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Jun
 2024 17:15:58 -0500
From: Shivank Garg <shivankg@amd.com>
To: <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>
CC: <bharata@amd.com>, <raghavendra.kodsarathimmappa@amd.com>,
	<Michael.Day@amd.com>, <dmaengine@vger.kernel.org>, <vkoul@kernel.org>,
	<shivankg@amd.com>
Subject: [RFC PATCH 0/5] Enhancements to Page Migration with Batch Offloading via DMA
Date: Sat, 15 Jun 2024 03:45:20 +0530
Message-ID: <20240614221525.19170-1-shivankg@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DS7PR12MB6358:EE_
X-MS-Office365-Filtering-Correlation-Id: 95a3e122-4642-46fd-967a-08dc8cbf9468
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|36860700010|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVpnZ3lKY0FzbU0xTjdGRjdseUt2MXNFdW9pTzJZMWRFMGo3SFh0WlZTTjNy?=
 =?utf-8?B?d0U1NHVzUitXdm1laWpUUnNMVVNSL2hCcTFyWEt5aXk1WGo5S2VnaU9PbTQ1?=
 =?utf-8?B?REJYaVd5dnJQUFphUFcrbjdGcE50QVVYOEtvZnd5KzRNd3MxQXJUQmVuckJK?=
 =?utf-8?B?ZW9CZEZIelRZWWxBa2wxRnh0UVZibVUxdHN2VXZNcllUS3JCeVMrU2hqY1RP?=
 =?utf-8?B?RWR5bTErL3NJendQMDJFMGwxZjMwU3ZLME1EeUp6azRmMjJyZ21ITUJvWExo?=
 =?utf-8?B?ZjNSNHdrbW1jYlFVNVR2N05EY1V3U2VMcWZBZG5RMXFETVpwOVRCQ29Ma2lW?=
 =?utf-8?B?c0RYM1ZqOXNFU1VJQVZsM0JrTzJoY1JZWW9mdUJsYzNUZVBjK2l3elJiTi9W?=
 =?utf-8?B?Ym1VRVFtdks2b3dBSitoa3NrTmt0UmNrMUtTcTc3N0JnMjMxSU9LQm9ZWVRX?=
 =?utf-8?B?UlVsQzdKNFhWU0FvMUZORU1Kdkp4akVUY0lhSFQzUGcwckRaUVdXRmJ0Vjla?=
 =?utf-8?B?Z0JhcFNhSDZVUVM0aFRQS3F3RTZBZ2U3MWh4OVNkbHorRVdYNVJaT1FNV080?=
 =?utf-8?B?MFgrWEZwYi9nTm9UeElCanZBYUZuTHowelgzSGd0RGltQTVFRlRhZTJpZjJB?=
 =?utf-8?B?eHppQmk5bkJ3YkJuSVZQa0lEdVJVWnpzTlc4T1VvY1M5bCtsMTlPSFhTK1Vq?=
 =?utf-8?B?MkE5VVNVbTFiMUJlMFFmRytIMlMwOUdwUGNYdXVHcWlDZ2sxcXY4NVNjM05m?=
 =?utf-8?B?U3d4WDVpUGhJVjZCa1pFT3FnMmlQRDZrRHIyMGZxOFpUVXd3NlZRdi9iTTM1?=
 =?utf-8?B?ZlJrcWdmN0t3ME9jYXBqMytsZkNzQWJ2WmJSendsTXdzbmZhL1FFS0ZCQm9H?=
 =?utf-8?B?RFF0b0ZLZFRBU0pwbVNQN1RqTEt3bGwvellmUHBmSWIwZWZUMitLbytoNFVn?=
 =?utf-8?B?ZUQyOENmd0dwWW5JaHVtSTRxZ0taOGVVMU1QZ0hHekExaXhCb3ZpTmYyMC85?=
 =?utf-8?B?elZ6VTMydVhHL3dNTGFlNGJBdUJ6d2lqR3NtV1RvTE50UWRTSXlaNEVXR1lR?=
 =?utf-8?B?cW90a3dUTm5ld0VwNHNxZXk3K0JXRlhENytMRzR3cmI5QnVTTXRlOUZIL3FZ?=
 =?utf-8?B?b3o4ZXhyR0laMTh5U1JKVThvbUhvVXMyS1gyZzM0Y01iemtRQ05HTVNibWdL?=
 =?utf-8?B?TWtRQVBJelp1K3lSZW81eTdPbm5kMUh1dEh2QnZXbVdPMGl2VmZkbXcxSTR6?=
 =?utf-8?B?QngxUnErL0xEUWFrZ2NhMkk2NUFFeWFHdXdMWTl0SUZNR0xhdXJiTnNxQWto?=
 =?utf-8?B?ZmFWVGhJVzVvVUtpWTIxZGRhNE5JUkZGeER6djVud2cxaXhxZ1liazgzUzBk?=
 =?utf-8?B?dVd5enY2bi83ZE9GUlIzZXZHVkYxZ0xWdm4rNTdIeGgvZUhkZlVwR04vVWZa?=
 =?utf-8?B?OUxtUE9NUmZQVVJrU1d5VjN2NzhzdExCblJNQm9yakNXWXRRdWVra3dxWndv?=
 =?utf-8?B?OE92Qldidk9RUlo5OHZvTDV5U1pCc25NRnc4ZVpPWmtZTGxBSnQ5SmpsMmhT?=
 =?utf-8?B?bmtZbGNMWDJCcjNiQ1p3ekozVk9KTzUxVlhyR0xsRU05Q1RBNWNOeUxtZkdJ?=
 =?utf-8?B?Vmd6VDY5dHEwKzBHL2YyR1E5c1BhUW9RRWszblJpeU1RczdiRklDcC9COW9k?=
 =?utf-8?B?alNNRGNJczN3OW5HbHRyRHZ0aXh4bjE3RDBaa3poQkNsT2RiaGRjdTZ6a2R5?=
 =?utf-8?B?VmR2WmZjNjVWMkVUeVVkTXNieHF6enZ0eldBVVJybGJvSEtBZ3BQYk1ITmIv?=
 =?utf-8?B?Vm5OTGNlL2tpSVpibWRRVzhveHdTZzg0OStZVmg1VDRYL0F5UFBTbW4wWkhB?=
 =?utf-8?B?NHh3bWhXSzU4U01jRE9JM1l2QjJqNHc0OFZPWUFzc1RGZ0E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 22:16:03.3167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a3e122-4642-46fd-967a-08dc8cbf9468
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6358

This series introduces enhancements to the page migration code to optimize
the "folio move" operations by batching them and enable offloading on DMA
hardware accelerators.

Page migration involves three key steps:
1. Unmap: Allocating dst folios and replace the src folio PTEs with
migration PTEs.
2. TLB Flush: Flushing the TLB for all unmapped folios.
3. Move: Copying the page mappings, flags and contents from src to dst.
Update metadata, lists, refcounts and restore working PTEs.

While the first two steps (setting TLB flush pending for unmapped folios
and TLB batch flush) been optimized with batching, this series focuses
on optimizing the folio move step.

In the current design, the folio move operation is performed sequentially
for each folio:
for_each_folio() {
        Copy folio metadata like flags and mappings
        Copy the folio content from src to dst
        Update PTEs with new mappings
}

In the proposed design, we batch the folio copy operations to leverage DMA
offloading. The updated design is as follows:
for_each_folio() {
        Copy folio metadata like flags and mappings
}
Batch copy the page content from src to dst by offloading to DMA engine
for_each_folio() {
        Update PTEs with new mappings
}

Motivation:
Data copying across NUMA nodes while page migration incurs significant
overhead. For instance, folio copy can take up to 26.6% of the total
migration cost for migrating 256MB of data.
Modern systems are equipped with powerful DMA engines for bulk data
copying. Utilizing these hardware accelerators will become essential for
large-scale tiered-memory systems with CXL nodes where lots of page
promotion and demotion can happen.
Following the trend of batching operations in the memory migration core
path (like batch migration and batch TLB flush), batch copying folio data
is a logical progression in this direction.

We conducted experiments to measure folio copy overheads for page
migration from a remote node to a local NUMA node, modeling page
promotions for different workload sizes (4KB, 2MB, 256MB and 1GB).

Setup Information: AMD Zen 3 EPYC server (2-sockets, 32 cores, SMT
Enabled), 1 NUMA node connected to each socket.
Linux Kernel 6.8.0, DVFS set to Performance, and cpuinfo_cur_freq: 2 GHz.
THP, compaction, numa_balancing are disabled to reduce interfernce.

migrate_pages() { <- t1
	..
	<- t2
	folio_copy()
	<- t3 
	..
} <- t4

overheads Fraction, F= (t3-t2)/(t4-t1)
Measurement: Mean ± SD is measured in cpu_cycles/page
Generic Kernel
4KB::   migrate_pages:17799.00±4278.25  folio_copy:794±232.87  F:0.0478±0.0199
2MB::   migrate_pages:3478.42±94.93  folio_copy:493.84±28.21  F:0.1418±0.0050
256MB:: migrate_pages:3668.56±158.47  folio_copy:815.40±171.76  F:0.2206±0.0371
1GB::   migrate_pages:3769.98±55.79  folio_copy:804.68±60.07  F:0.2132±0.0134

Results with patched kernel:
1. Offload disabled - folios batch-move using CPU
4KB::   migrate_pages:14941.60±2556.53  folio_copy:799.60±211.66  F:0.0554±0.0190
2MB::   migrate_pages:3448.44±83.74  folio_copy:533.34±37.81  F:0.1545±0.0085
256MB:: migrate_pages:3723.56±132.93  folio_copy:907.64±132.63  F:0.2427±0.0270
1GB::   migrate_pages:3788.20±46.65  folio_copy:888.46±49.50  F:0.2344±0.0107

2. Offload enabled - folios batch-move using DMAengine
4KB::   migrate_pages:46739.80±4827.15  folio_copy:32222.40±3543.42  F:0.6904±0.0423
2MB::   migrate_pages:13798.10±205.33  folio_copy:10971.60±202.50  F:0.7951±0.0033
256MB:: migrate_pages:13217.20±163.99  folio_copy:10431.20±167.25  F:0.7891±0.0029
1GB::   migrate_pages:13309.70±113.93  folio_copy:10410.00±117.77  F:0.7821±0.0023

Discussion:
The DMAEngine achieved net throughput of 768MB/s. Additional optimizations
are needed to make DMA offloading beneficial compared to CPU-based
migration. This can include parallelism, specialized DMA hardware,
asynchronous and speculative data migration.

Status:
Current patchset is functional, except for non-LRU folios.

Dependencies:
1. This series is based on Linux-v6.8.
2. Patch 1,2,3 involve preparatory work and implementation for batching
the folio move. Patch 4 adds support for DMA offload.
3. DMA hardware and driver support are required to enable DMA offload.
Without suitable support, CPU is used for batch migration. Requirements
are described in Patch 4.
4. Patch 5 adds a DMA driver using DMAengine APIs for end-to-end
testing and validation. 

Testing:
The patch series has been tested with migrate_pages(2) and move_pages(2)
using anonymous memory and memory-mapped files.

Byungchul Park (1):
  mm: separate move/undo doing on folio list from migrate_pages_batch()

Mike Day (1):
  mm: add support for DMA folio Migration

Shivank Garg (3):
  mm: add folios_copy() for copying pages in batch during migration
  mm: add migrate_folios_batch_move to batch the folio move operations
  dcbm: add dma core batch migrator for batch page offloading

 drivers/dma/Kconfig         |   2 +
 drivers/dma/Makefile        |   1 +
 drivers/dma/dcbm/Kconfig    |   7 +
 drivers/dma/dcbm/Makefile   |   1 +
 drivers/dma/dcbm/dcbm.c     | 229 +++++++++++++++++++++
 include/linux/migrate_dma.h |  36 ++++
 include/linux/mm.h          |   1 +
 mm/Kconfig                  |   8 +
 mm/Makefile                 |   1 +
 mm/migrate.c                | 385 +++++++++++++++++++++++++++++++-----
 mm/migrate_dma.c            |  51 +++++
 mm/util.c                   |  22 +++
 12 files changed, 692 insertions(+), 52 deletions(-)
 create mode 100644 drivers/dma/dcbm/Kconfig
 create mode 100644 drivers/dma/dcbm/Makefile
 create mode 100644 drivers/dma/dcbm/dcbm.c
 create mode 100644 include/linux/migrate_dma.h
 create mode 100644 mm/migrate_dma.c

-- 
2.34.1


