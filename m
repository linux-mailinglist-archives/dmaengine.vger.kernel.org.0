Return-Path: <dmaengine+bounces-4884-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C22A88F00
	for <lists+dmaengine@lfdr.de>; Tue, 15 Apr 2025 00:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3540D3B1585
	for <lists+dmaengine@lfdr.de>; Mon, 14 Apr 2025 22:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2458C1EEA4A;
	Mon, 14 Apr 2025 22:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IAYrmMA/"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA4F1A0BFA;
	Mon, 14 Apr 2025 22:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744669381; cv=fail; b=FDFgMNzMvWQpnC5++NBqNQgS0n/ZRR8r58m3Tk5cNzQN+6prMsLRUdOOMjHlMyD1FWGKHT6t0yL5J9W/Mw+1KseOr+cWlinL9thM8qVT4IcFwkdzv0SnLieZ/gqNkQiareKjzH+ew+SetDTGCdDQl/YwU9NCa8qK9KQf5Nk0cR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744669381; c=relaxed/simple;
	bh=T4H1ttHBbcTDkhLqeUzOfIxR72ymCu4IKQJfARLvl6o=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=as4qAEW6V2vX6kHeATtsXrAjuCM/94VJMLpVn6hd5iAOupycjpweoQB471w2KRvgcC7FW2GWPZMyW7rVtIc2AWBpBOY9ZEoOBudNxadp3h1K3vmkt6j2WPkNB67WrFv/7dMl82MvunekoYbtiaeuGCRIPwC+BZ9Ls+wCwI8Gbi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IAYrmMA/; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbA07TOWCX58A8OhZYBw4BxNljUMxilivK034Vzad7+6QuRwcJokTQYxA6SfTS+gw51Qp2tJpJoIw13HI/yL0JeUJdLae1XUfu/ALS9K/dhLl24dJgA2mH2oBam3luO6K+C/KP8U8j6Y3+v9WdgTrlDZSgrLq7uml2csiY/zHw9YY2PsQdbapUJqHiwGtw1e0sCajiTOfCim+McZXxYuuf3szf1rw1NOoEWZYgBNiXfjOUrtrUnCE/6VYf8tYg4RGC2RAUG1PhuKlD4YhdRW7bS+tMYMJRmFqXDEsGqWl6+6Ug3YB51gmHT5Ap9ZeYRnmeadWEAK5wjBr41y+VSq8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O04tSvbBizD61VC9DclIVAKvY35WbHPv/SPzjsb56s=;
 b=N/2DHWt3zOtEM4Gwua7XdWCN/nQkTco5aC7qj+licXi8KzPexA0FSxGBetq4iAQRmE1T4KPugHNmjTacxURxteDw0zPTXZD879KHE936FThhtB5Y/9ZpKXhjt23voef4mnxeNeu6QpLa1JMqVzrW7ieqe2RAaBFEdR1ave/owmyjiqHmGtmnudR4pzhPTWUFqQ1Hte6JxvGJXVOoEE43u6njKyVHn2YvMwoNu44dVTBZHVCOOK7477yE5Vy1om/oOcBnyn5nwb1ed8MvWGYcoAnqoy/v+37XTFmqeFRbmUmzUYeSuHCQjV62EqWx+Ule9xGUdJU0gIxuaPsEywMMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O04tSvbBizD61VC9DclIVAKvY35WbHPv/SPzjsb56s=;
 b=IAYrmMA/KAHF7cIeeUg047FrFBjnTdcdRjjsPGe+OLEb+hntDR+qCeeeEftGNsaGfGhvdYbgWTLXBms8uXXjpgxgJ6E7QsJcwuyjBejbwscwgSIIm3Uaw9Tf1fsT7pZBmRnxRrxo3y4Cx+TrSUKu8++NK3ywKLO0jFlwq4KgadU=
Received: from BL1PR13CA0024.namprd13.prod.outlook.com (2603:10b6:208:256::29)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Mon, 14 Apr
 2025 22:22:50 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::fc) by BL1PR13CA0024.outlook.office365.com
 (2603:10b6:208:256::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.10 via Frontend Transport; Mon,
 14 Apr 2025 22:22:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 22:22:50 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 17:22:50 -0500
From: Nathan Lynch <nathan.lynch@amd.com>
To: Vinod Koul <vkoul@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Revert "dmaengine: dmatest: Fix dmatest waiting less
 when interrupted"
In-Reply-To: <20250403-dmaengine-dmatest-revert-waiting-less-v1-1-8227c5a3d7c8@amd.com>
References: <20250403-dmaengine-dmatest-revert-waiting-less-v1-1-8227c5a3d7c8@amd.com>
Date: Mon, 14 Apr 2025 17:22:49 -0500
Message-ID: <871ptu8jt2.fsf@AUSNATLYNCH.amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ae5b126-90a8-486a-7193-08dd7ba2e480
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pUZaFWiLTzrDGiYkIFkDqrfk/om8razP1whHkbVQUOiFW+HlfIookhDDbtVj?=
 =?us-ascii?Q?K7Kfgj5S9hG/4mYgIXKM6FiGkSkNcrquOsbH9zhcrsSaXRllXQ7yU04888Ks?=
 =?us-ascii?Q?5e6h40YazJRFnDeIgoov7RxgT+uAFEui2RsLmERcJ8jpkidH3fJe0DTu3m2e?=
 =?us-ascii?Q?fIIhdCkdh5O9ZiPMFr19xC8yld7Zyy2B+xtbREmgVROrFfZj2duMQJhSW+68?=
 =?us-ascii?Q?0CD6oX1f0H1Q0zTgnpxPiBtfVPBBr5L6vYNAMjTPORcsIBESxWvTyNMztPDY?=
 =?us-ascii?Q?1h7EvQIWJxG4i59TmymuW7IHaRCpwgYZLdhqeY7fX01/2WFy2p6ZEpEcuIfN?=
 =?us-ascii?Q?w6UMb+8+hDbtOo4vACG/1eWJJTTsw6Iw7waqM+wXYC0lQf6p/ZRdcyzKn+qz?=
 =?us-ascii?Q?APt9KLqhcFgKaDCj3yBSQJSmlcTGX5bpaNcvH2cX6n+psS+xCkuoCLJ66w6B?=
 =?us-ascii?Q?mRducz2gXSbqL6JKerKoZ3iYWFWQ8ZvXUxDyA7zHl5I/Hcry/X3R9hFPHOQQ?=
 =?us-ascii?Q?bAgyUkWW0PZsjF26FHZApurNYaobpNQ1soMw6fvtQ55FORE+I7L8SCMtNOZu?=
 =?us-ascii?Q?OfYzFwKa6MNYSwsE8K6oy15IXvPwUrEWXQWtbXN1KxTfgD2ZBNhs9zvVAM5E?=
 =?us-ascii?Q?8e18i1r6cE4L17cnRIqb28gN2b9RYsRvjZYcJTJpYHC7fbZ63bzxA2k55L0t?=
 =?us-ascii?Q?iYC/FDatrRZ9HL2ZzXw/v+GcV5FoYhSgj4EyJDh4WSRARBLKzTypLTCJ7JSD?=
 =?us-ascii?Q?+sZ6byjmNM3upd484+HdqFOuCTnzDuRS0bGfzxQfBXrP+ckLIsjvsQTfOGrf?=
 =?us-ascii?Q?wtECVmLo4Zt2mJR4HBS7dJTJ7YFrsMJIcChlqLZmutseic1d0YDdR3rmEzIh?=
 =?us-ascii?Q?4tbGVAO3A/AWTdHUGTeMVPoh+3DLWHRTC9ojXYawbiZDKEHvz/VsZl5JZS10?=
 =?us-ascii?Q?+4ImoZNbV/KwzSDeeMOuiYAEBdBQg3Wipp7PlTr7YAMRsfKCyXit/kzIEgHG?=
 =?us-ascii?Q?VR8KZOTbDeSVjEPwJVqerMsK8z0YipxE7p6Ueps61YQJbHKLuTNRsaxZBEIw?=
 =?us-ascii?Q?Pk+SYAX3NV5jV+QB7Ifni+JQj+oVMpwgp+5ZALadPwdMD7KXWtBia0UdpK65?=
 =?us-ascii?Q?/ea6JJhAE2FqeEPg0FP0XbpN9JNvh+gStqe48n+i4ej6C7HhmU7sO13O4+3r?=
 =?us-ascii?Q?2dW1dme1mxTDc9gfB5Zs1JbpKM6FNmCND8HN9BaisEta7R3lTGJ1HWeIfR3v?=
 =?us-ascii?Q?1qnznNNYAkOktaWmIxJgKGAjmW91UQf8YpivHrI7BRUU6Pmir16mL/uu4fHy?=
 =?us-ascii?Q?LCPB2PUkbztJkYhkMy8MtljJtlRD9aCtWfLral9qLs22i2TQ4LXo5Ys6rXJe?=
 =?us-ascii?Q?/fFs426fVXqOrgfMk0Whq3EmW/n1kBelT6j3LUQzdhQjZs2mpnY4UB9O9bZE?=
 =?us-ascii?Q?bbEKPvXzYf1TV5qmt9gm+JFkhnuZHEB6WdyoJdzs39VUMvg+oNlHWI+DBxJc?=
 =?us-ascii?Q?4+JmiKd4K9NmrKcI2tqk5ifE+YhdvnvqXgLW?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 22:22:50.4551
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae5b126-90a8-486a-7193-08dd7ba2e480
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580

Nathan Lynch <nathan.lynch@amd.com> writes:
> Several issues with this change:
>
> * The analysis is flawed and it's unclear what problem is being
>   fixed. There is no difference between wait_event_freezable_timeout()
>   and wait_event_timeout() with respect to device interrupts. And of
>   course "the interrupt notifying the finish of an operation happens
>   during wait_event_freezable_timeout()" -- that's how it's supposed
>   to work.
>
> * The link at the "Closes:" tag appears to be an unrelated
>   use-after-free in idxd.
>
> * It introduces a regression: dmatest threads are meant to be
>   freezable and this change breaks that.
>
> See discussion here:
> https://lore.kernel.org/dmaengine/878qpa13fe.fsf@AUSNATLYNCH.amd.com/
>
> Fixes: e87ca16e9911 ("dmaengine: dmatest: Fix dmatest waiting less when interrupted")
> Signed-off-by: Nathan Lynch <nathan.lynch@amd.com>

I'm puzzled by the silence here. This is a clear regression fix and
Vinicius agreed that the change should be reverted in the original
thread.

