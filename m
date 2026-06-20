Return-Path: <dmaengine+bounces-11651-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Rfx4NGPHNmoPEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11651-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:01:23 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 640206A9445
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:01:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=cQXWdYZ9;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11651-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11651-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F3303012C94
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C3F258EFF;
	Sat, 20 Jun 2026 17:01:04 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82CD257452;
	Sat, 20 Jun 2026 17:01:02 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974864; cv=fail; b=NjsY7czGmlEmZ3Rq+uZXrs7xEq3D5/AKhIkyzwf+hApzQhTrxmQsPQw+5j0WQSiG2zabanIFa6ZNJrNIhOYqiBHgAhcH5uSZLJnic76hLdTni8VMBeXa3HmC3S9igAFbzigQGVJvOGfQ77rPx3iwv1cNGjnj+rgXlfH0eLi72Hg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974864; c=relaxed/simple;
	bh=2I7JW3iu+lbf6YXUK/MnjSU0hGlTxlTyle6IQMUXFZo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pVDvjksyQsr+Fum0/TkIPYA/bqWdfMsZfBoHb8nNUzFdX/p2dC7rmipld6SPxEa++07M4YA6KOq9ARiQWK0msrjmToMwVhz+jAKXEJMcvu8NEanjQpJF5VORyuODGypKJVyQFYDO3YJnJORwLVVgz/X4N+9l6gB79wI0tWsPqvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=cQXWdYZ9; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ykcy7b9usvIIKfuB+6xpD6FU6MI6D5mga9Dw6CaKncFzilNPp4VAQRRtMibpvNl8GWWwupqfqYp57nva7APqk32HGoVkHu/4I1F+izR9mpVNDSOjA3dmMt1MPVWBiXC06TdQk0XvuGjYCTSPcyq1Dwf7vekZGSD2mla0bAFVhgm5nIOXDfBMc29oJinLXC/vTSS0EmS/NDJYQg0MnJrG15BVQ0Ke+bsqT9rkMguWIPVRpWg4vN047w89ByoJrsw4jH3EiP/4oJPnZ+hfgg6elYo8GoYIkFGKCeaoPD9cgzpc7RbN3rsoh9V5a4kUj1hTZ7CVietNK8x9MJ3QXxGkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/+8sYKRkMcdOKXg4B7EZQGMKx5Nsb5GeVgR+ZUd2Tw=;
 b=QaAv7wQ/f/s/M156T9+gCXCpQiDFQAffh8Ui6syv5nrignrjGJuzswG5V4z5n2HkrR/hOiO1j0Cy+dSiyAMZnAS7CZgAMFgweEXvLJURLveA7zeTA3+UrgODGDjvvZJb3AEI6kNZduNO0juFjIB7tY6Az2v9IzhazSgZecE+w7k0ZbairMvvP5BmUCGd8ppGtQ1JTrMQ3MvOyig7NAwsaszjl/73Zv+fbokCQt6ZY2ZdaA6lp775YszUiuMPE1c13FXv4lCZN8lvTZNrwu/Sr+YfvashR/XLeCDEqJeCkmoeXc0KGJ+yB7IZTnPuVb6lHggUCcGrrQus4+In5rgwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/+8sYKRkMcdOKXg4B7EZQGMKx5Nsb5GeVgR+ZUd2Tw=;
 b=cQXWdYZ9+4JkhC13Y/z1MMmK5FFto2zRv2oz9ysqusJXy4hoV3+etzvM1dJZbT/sIzKGVgi+0D9p126SdfOXSrl+k3NS4r72+VsHyFEjHArNhIRpOHLA8aDxZot2BkPaI03qn2LfZLBnl48W7RaotS3LePZ37yVzHUi2PyPhMZ4=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:00:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:00:53 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/13] dmaengine: dw-edma: Prepare for PCI EP DMA (part 1/3)
Date: Sun, 21 Jun 2026 02:00:27 +0900
Message-ID: <20260620170040.3756043-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0047.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: b879b13e-233f-48c4-a2db-08deceed7d52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TixlkDyk8HDqiT8pPuMn7joLrMZmhEaBabBtv7tJ1b68VBCCJ5Krd2djRCo6ls3BaDIQcMh9zC2I5pgpihLTvemuROItmtdk15EfQ5iVwPqGTRWbJesg/qvF/VGBnqrna/ZzzsKQH4hL6ZDB4+Aqus/w/BcAI2CTwd+iEpwaYcP6unwkgolX6nNMobSE5MS4mukhlI/LK+Fx2gZyOGQGx8oXfHIDv5oxG910Ypw6OS/HMEOIYDYSrVrUMdW4FHq7gbYeiRpNHII4usccrIi53T+mRhTn15k1fgSVbR3eNqHEoslXw080WvrLUbozCj0/k4UMk3HfIkp6a5VPSNTBA9TQEXsJVOKUdCA5BbSwsWyeJXAQVFI70OG7t9N+qcDUfBMZ+aduLsTePIIiHqL4fCrcniMkMu1W3cI3sQ8njqWGkPFV2rupVTzhXUzo1BMwEASSnog8f1oO9WkKW4FVJQV2UdJlCS5dZwLn+gxzulibPKqAEAIrpHEm8LjruULZTpbaA1cJ3voGtgRUcxVrUMp+aCsyRYIzigVkUW2Rv3E6oPDK9EcVp5tCG9d1S+zcefqGZsaZgEN1djubT+YksJwUeLsdhVlrkxthJNHkZRNZfoV1l5Zt2ydSIeFJfPoEpWDS7674T0bJdiYp+Ju12UMMClE+KSxskR4SA2aQ4+o=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(56012099006)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/7RodaPyHsR2vRMeaK5RV2oyqnptNlwDgsDRIpDwG6rsy+amV9tbAH96rvcs?=
 =?us-ascii?Q?Atu7Hji5+T5hyf5z6LqUT0xL6yRUGrv+RDtZ/QiIGzAHATqM0v2Jyyg9GZ0/?=
 =?us-ascii?Q?QxRZyCyiZESkkGc2jMj7ePH2FHuCv303pduYixBPpYJ88Yl6NGztl+iMgevZ?=
 =?us-ascii?Q?Bx3jkWrfPM9L1hLlDcEbpS7ABXmPHacMV1nTJAxo3nJx4j7J0Q1vJStIrZYV?=
 =?us-ascii?Q?vzPWMcWow2hy/WmWmI18QqSIZoJmKntHdb4JH/YQCjxG2DJYSBKd2rmpfwZy?=
 =?us-ascii?Q?7CKtAd//fpnmJMaWxF/8IbXsLq/1IyFjQgsrJjop4/i3juXSf+zby8p3Ri+1?=
 =?us-ascii?Q?8dxdA91G+y2HIjWsv223n5i/jMw6i1yHMw9fCqh8y6dNZBR2sy1nsTn7UTSQ?=
 =?us-ascii?Q?xLdUg4dKbY+h1s1XlH9roVQyBV3w14l0/0+BKE6c5J1BURUyitRN5u8C/jPN?=
 =?us-ascii?Q?+Uvl/TX36x7j3y8Lgb/EYHCc+1+DqUI+1Y04h8nCVuIN2Zsi3J+0+FzEf93r?=
 =?us-ascii?Q?7jZV5IP/k0BWmMREOM6tjddf7B2RImjf6SiocSh6mIHr/5/V+LjVckFtpd7w?=
 =?us-ascii?Q?6wfS59xOcHxT0H8NGiDcdL7WxPBv8qMMnCHxkVp7oQLM4SjaGY0M3v86dVly?=
 =?us-ascii?Q?gEchdPVCDTdFXow+9Tw0B/sq4CRB1Q/us0ZftEO2jA96kwu9ivI8bpbd8EXq?=
 =?us-ascii?Q?rgDEB8Vv2B59tUBczUvMnwHi3TGvrmF0sSM6sbBIm5ZYRed+1cQoTfZFQwWi?=
 =?us-ascii?Q?5kvQfZHq7zT7HEoJ0SaJ1hJb78BJkOHvaYi1vHjrL6qrjX7s6IpMvmlOoaQ3?=
 =?us-ascii?Q?iPLnnkiv6mz4SCCBTf0n0GQfE1LgCgRx/10hDI9tAv4zcv1S4d/AXikEM6Jp?=
 =?us-ascii?Q?2kdCNyEtHD+twj9beBjRG5K9xKBrJ7FmGCNX/NQ8SY4lU7kHoYrZ6K+NselW?=
 =?us-ascii?Q?hPBTAJLk25eoy96BoBWCds1ybCQjEfB8DWVtCymlkscyKyy4rUzOAFOReFH6?=
 =?us-ascii?Q?wsdbC9rDRlQg449AGxc8nwqfEN+C9kpsv3iAzyz17iyqxqyGX+sbEClqL3at?=
 =?us-ascii?Q?CidU/sZA5sjwxJKN7djgsDq9DReAaKWjGf9ZkA8sFVyGbMR8v3Pb+f0Q0FNq?=
 =?us-ascii?Q?eh4q8ZlrZqHh58G7qUmOa/T+aLYXyCcXQMeMGfrsUIuVEgRvU/epCvn0odqZ?=
 =?us-ascii?Q?rStcFQfuDA/TRBs79M5bEN7TpG7Gd1DMoVNEQ49CRggkVqzPOy7biiZoeKGv?=
 =?us-ascii?Q?cnRCS35qd7r6dHIVQ2S0xNtGDyzUgeAyXZimTX6bizmfeVCiZ+VJ8jRDsji9?=
 =?us-ascii?Q?X6d6cw5Faq2kc1ywj4JtE0eFAgCJYx1XkJXE/IFK+4Cewc5Iq4si67ZcUURs?=
 =?us-ascii?Q?Rp4tVJ9YkXApTi4srM1Puf3NQPwce45ngPcX5XwbGaJVhfXOiiOOWIsfTZ4f?=
 =?us-ascii?Q?ccvV/kTZngwYoQ/MT5IesGk2PiSF510BL7K4bZsuKPWXvHuLWlxPv1GAnBII?=
 =?us-ascii?Q?PLFSP90opD7BHz0nZJHSRtIxdgRgD3rbgWpMlP4Xr64E4z5q+FUa5KUR5Qci?=
 =?us-ascii?Q?UkDTtz60kIwBpD7sSB0qU3efx8SKDqWViw3N3V6zvztU0vG9kPVwxPgtpea6?=
 =?us-ascii?Q?+yQIRZPFyeX3uPVtpni58JPZpp5fymZ2Hwl0U6kH4UcgfOLmb71yA4/rlR/9?=
 =?us-ascii?Q?fTsRGdmiHPfgv3ztR6GAhfNiAZ/z4d5GfQoeFfdgEwEGSYukY4W13HJHE1pc?=
 =?us-ascii?Q?zl2jIj2ZB6lTqDMju0dDQjmUZgJqMEm1XKdB2velHp8d0UtD8/Wh?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b879b13e-233f-48c4-a2db-08deceed7d52
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:00:53.8963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0BsL6NYvZTyTNjdRXfk7j25o7tzIrlhb4HWRK29M0ifdzzaAKnzgj8j0xxrlBMYQQfzDZx7BxeDdASh4gxoXCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11651-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:mid,valinux.co.jp:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 640206A9445

Hi,

This is v3, part 1 of three series for PCI endpoint DMA.

The three series are:

  * part 1: dmaengine: dw-edma: Prepare for PCI EP DMA
  * part 2: PCI: endpoint: Expose endpoint DMA resources
  * part 3: PCI: endpoint: Add PCI DMA endpoint function

Most v3 changes address review comments from Frank and Sashiko. v3 also
extends the DesignWare DMA groundwork for HDMA native.

This series is (re-)based on linux-next next-20260619, where the dmaengine
and PCI endpoint changes needed by the full three-part series are both
naturally available. Parts 2 and 3 depend on this series.


Scope
=====

This series prepares dw-edma and dw-edma-pcie for endpoint-local DMA
channels that are delegated to a PCI host. It does not add the endpoint
metadata format, DesignWare endpoint resource exposure, or the endpoint
function driver; those are added by parts 2 and 3.

This part is the DesignWare dmaengine backend work. The endpoint resource
and endpoint function pieces in parts 2 and 3 keep the generic PCI endpoint
interfaces separate from the DesignWare implementation.

In summary, this series:

  * adds per-channel interrupt routing so a channel can report completion
    either to the local endpoint side or to the remote host side,
  * adds quiesce operations for the resources represented by a dw-edma
    instance,
  * adds helpers to reserve exact DesignWare hardware channels and hand
    their interrupt ownership to the remote side,
  * adds partial channel ownership mode for dw-edma instances that share a
    controller with another OS instance, and
  * prepares dw-edma-pcie to describe device-specific DMA layouts through
    match data.

---
Changelog
=========

Changes in v3:
  - Replace the public dw-edma hardware-channel filter API with delegated
    channel request/release helpers, keeping the DMAengine filter private
    to dw-edma. (Frank)
  - Rework IRQ routing so local routing is the zero value, existing
    dw-edma-pcie instances stay remote-routed, and delegated endpoint-local
    channels are handed to the remote side explicitly. (Frank/Sashiko)
  - Add HDMA native interrupt routing and allow channel-granular partial
    ownership for HDMA native.
  - Add quiesce operations and use them for delegated-channel reclaim and
    partial-owned remove paths.
  - Reintroduce the IRQ data initialization fix because partial-owned probe
    skips the core_off() reset that previously made the early-IRQ window
    unlikely.
  - Adjust dw-edma-pcie match-data preparation for the CPM6 entry present
    in the new base, and reject dynamic PCI IDs without match data.

Changes in v2:
  - Move non-LL state and platform ops into match data. (Frank)
  - Use a named .driver_data initializer for the Xilinx MDB ID entry and
    fix the vsec_data rename patch title. (Frank)
  - Replace the dma_get_slave_channel() export with a dw-edma channel
    filter for dma_request_channel(). (Sashiko)
  - Rework the IRQ-routing config as dw_edma_irq_config, keep HDMA native
    int config separate, and reject remote IRQ mode on local instances.
    (Sashiko)
  - Report IRQ_HANDLED only for status that was actually serviced and drop
    the lockless free_chan_resources() reset. (Sashiko)
  - Tighten partial ownership: reject unsupported map formats early and
    require direction-wide ownership for supported shared-register
    layouts. (Sashiko)

v2: https://lore.kernel.org/dmaengine/20260525062420.3315904-1-den@valinux.co.jp/
v1: https://lore.kernel.org/dmaengine/20260521063115.2842238-1-den@valinux.co.jp/


Best regards,
Koichiro


Koichiro Den (13):
  dmaengine: dw-edma: Add per-channel interrupt routing control
  dmaengine: dw-edma: Add core quiesce operations
  dmaengine: dw-edma: Add delegated channel request helpers
  dmaengine: dw-edma: Initialize IRQ data before requesting IRQs
  dmaengine: dw-edma: Add partial channel ownership mode
  dmaengine: dw-edma-pcie: Track non-LL mode in DMA data
  dmaengine: dw-edma-pcie: Add capability match data
  dmaengine: dw-edma-pcie: Rename vsec_data to dma_data
  dmaengine: dw-edma-pcie: Add platform ops to match data
  dmaengine: dw-edma-pcie: Add register offset match flag
  dmaengine: dw-edma-pcie: Factor out descriptor block address lookup
  dmaengine: dw-edma-pcie: Handle optional data blocks
  dmaengine: dw-edma-pcie: Add chip flags to match data

 drivers/dma/dw-edma/dw-edma-core.c    | 150 +++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    |  27 +++
 drivers/dma/dw-edma/dw-edma-pcie.c    | 253 +++++++++++++++++---------
 drivers/dma/dw-edma/dw-edma-v0-core.c |  46 ++++-
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  68 +++++--
 include/linux/dma/edma.h              |  51 ++++++
 6 files changed, 479 insertions(+), 116 deletions(-)

-- 
2.51.0


