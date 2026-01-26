Return-Path: <dmaengine+bounces-8481-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +P82Or4Zd2kCcQEAu9opvQ
	(envelope-from <dmaengine+bounces-8481-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:37:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F7484E1E
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 08:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E2983006788
	for <lists+dmaengine@lfdr.de>; Mon, 26 Jan 2026 07:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBA62D839C;
	Mon, 26 Jan 2026 07:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ASsx4Ht2"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021104.outbound.protection.outlook.com [52.101.125.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA542D6E5A;
	Mon, 26 Jan 2026 07:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769413045; cv=fail; b=GgftTkOLmhHN7G5mzrzWQ7Iy+R5b56bER1ZDg/Q7O7sjKMC3yADi8LM8VAbndND/Vkai7JbLmWTAeBeYFprTyWL5ZO41hO1AdV8vaButJFdSrgUkWmJdK1LIy24ReqGNznq22avyMVNlDcV9v4guhT1AIGuOQKnI3foO3sXnz94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769413045; c=relaxed/simple;
	bh=51Qf6qtqpHPSrOevyQgT2E7D6WnkVcrLw44/aVXHoCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FZc8b8Ts3SHZC5vqpcIHI9QlO1hj5wVdSRsRmTyPytmA5bhotHn2GTEuGkKvAlNmomCtzCu0zQYdGyFaY3mK/+d+x3b/CDcAGtlLjIMd643A1nwW/EvoVwvHdbRgsSoJgVrMsTJbf2659qCF/+RqsKKrt66ih/I8eLwbcMdAuMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ASsx4Ht2; arc=fail smtp.client-ip=52.101.125.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hRGALeNrV1XLNGaNqvAvs9mjDl6AvCbP9M16fBBADPyJVPkg6w0T1vun9qfef+jHiK8Kig0MzLZVhAkYMPFDGMS459VFy9GVrvVShbOv/psJeLXL32cdBFHBUVPG9T+XkUDrZ4T3S9P6h+BFK24GMZPp0nrau1pRvgXbSiLcVZDETsOt/2pysKRsYv9DBEXftdwe1w65lJuxnlZFMjFtO5DvPdUc0lPx5r8lSPVeeJjT3NTbAw8xoC51mKc3IRmn8aAawUqfalBrcZfL75WtiGETxulR6ior4fUlbFGTZWM+ZSZlCJnuAT0IuR/ivSZwiFXPudvL6brS7CvqAbyIJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dxSyS2mhCqhW3G6O9AwHIc0j2k4qcGaEtcjBNZM1SLE=;
 b=cHa1W1M+xXw2QiSQpWVyuUpHiZS+glI7XwGUMoZxiBY1R5p5r5HdPnlCjTlR/ssKQ51nCzXIEvNPr8sWa4qYZifOdPg+SziTptwBeCXnAl7QN9H9Rt70ganuO0mcVXXVi79JCcdZrVUO10u891rh55o6o9ix9YVmDBfOL9S/NCZwTM6qN9d3KIDLzZbMsQ0seTEs1dUDAdl0bdhXA8inXA+nqK27e/S46E8Wco5GiBrMLT5Jl1uZm9V9r0S/cWIYRRcEi6HgH6zsNo1QVC326Gb1HZzvCgD6yeHej8Vt77gbjjWJzc6IwZTd+S5jKm+uuS5kBLM9PESwWBw/bppcYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dxSyS2mhCqhW3G6O9AwHIc0j2k4qcGaEtcjBNZM1SLE=;
 b=ASsx4Ht26Hvknkwn/xOLPVrbeSacPEiHGFtUc9gIpE1zX324OK4FsFaaNwtfyVxo6uGKcLxWsZA7ZzNCVimkYv90v6bbo9n/dFsnTZXJsEo2X/OaBXvR2SPf3rSob7HiIvrJxJAW7j87dcNTO0/yWG/rqRP9VwpMpxr3L1TdvJc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6300.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:420::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.14; Mon, 26 Jan
 2026 07:37:07 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 07:37:06 +0000
From: Koichiro Den <den@valinux.co.jp>
To: vkoul@kernel.org,
	mani@kernel.org,
	Frank.Li@nxp.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] dmaengine: Add hw_id to dma_slave_caps
Date: Mon, 26 Jan 2026 16:36:48 +0900
Message-ID: <20260126073652.3293564-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126073652.3293564-1-den@valinux.co.jp>
References: <20260126073652.3293564-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0011.jpnprd01.prod.outlook.com
 (2603:1096:405:26e::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6300:EE_
X-MS-Office365-Filtering-Correlation-Id: e5c3146d-c7fc-4aec-5e5c-08de5cadb4f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8zFSkdU48CRV+R+9Y0qRLzxrBftU7qUiY0jb3+ICr4W47E3xDOPTD2LaFgug?=
 =?us-ascii?Q?aUbQxcDUKGZOfo4HzMhw1khgiyvpvA0iwVIkZhXRE55n82bUgkiTpIxksJiH?=
 =?us-ascii?Q?ELls9goqLZnHkqOlaq/vKVX8ATyCTzxouh/4I0O6cxwuppgxIUus43NvuB9d?=
 =?us-ascii?Q?SZDEbFMQ4+Fx+Qnjh+MRbfp1GajaTHzMetBGTW8RE0e1o7pi5KjLx1esCsnH?=
 =?us-ascii?Q?8W2pDEzrgxmwdythYVaDkdOzE7VfpCg7WSpv2AFG7D8eCG7cNlLF5lH1ZgWA?=
 =?us-ascii?Q?yssNTtfCoZx9vBYecLpqcixxwY8P3rp83RYaJJxr8NPyMIC7w2SBUPjs9V+m?=
 =?us-ascii?Q?w0A92YmWrB+wEj/G02AJw/9sfGYMUhiJMc5WLLtPhtOOwyk1ewM+o0qeF5l9?=
 =?us-ascii?Q?5R5fkXF/btKtnv5k5I8zNa/sUkIkAsrbIbeoKKD+34FdwzpQl7NRpGAhvOqA?=
 =?us-ascii?Q?kLX3dPaClybQv4dSvhQDTUl2k1gRAvms02QvAf5M1j4iIzVrYWlS9zy/w1dM?=
 =?us-ascii?Q?DXNGirPHwUO9Tqh4y9LpxyeYJFKdsSQY6ZHQODLaG9+BDI1i9IlSKWfa1qvw?=
 =?us-ascii?Q?OkMoQSs2GlKZWGusfSyibMT1mbb4HJjRuq4ryuW9Fa0+Lw4PnNigWVBajkkA?=
 =?us-ascii?Q?EFhbUjj82S1Z0hwMYyUp6c5k1/rr26q0PgPTsnqr0rJJ0tctdON2WuLMWTnl?=
 =?us-ascii?Q?214Og1hjaCCh++8qFGvqqHzvLan50naOlSXPJJXqpGv4JvXsNoGJ5R8+LpTP?=
 =?us-ascii?Q?x20Jh6U6oyGaC+oUL9ojwmAV4q9Pz/sJcLbjR69SUBAbFh8/MVdX0JvChet4?=
 =?us-ascii?Q?sn2+PNiiLV4mu0P34N1ZQYUsPsPALANTFttM69/ZrixEvMZ9r5nKxVO2qzNb?=
 =?us-ascii?Q?+SQFlrtLt7Y58q5MG11lTTa977iBzkLcpIdeEXbxm0Tk3rfVWgh38Q5WPzbC?=
 =?us-ascii?Q?zlXOpi030AtZJ9p9ZjOYxKei5AE5DXCjsvbeC4KlOc+4lyMD0T1WQXN7huwt?=
 =?us-ascii?Q?OQFq9JRRUzpa6Y979umVNfr72sjfd4gr0v1NOuuxvmZzyNztJfX1O3H6O6ha?=
 =?us-ascii?Q?d2XDYsydHAgmxftFRSJCj95wC/Cq7IWm2tQPeIVYpaGrq1vrO+cfTnzyFw8r?=
 =?us-ascii?Q?cEdDvEAtQ7wkFQCSf5by/s5l+/tuzEpHzI4u625CRnE8FkZTFQ6DRihJK/iR?=
 =?us-ascii?Q?LT8wE/YDGfbNGQe3A0R9xNK9Kc2t73evNjK3Khc/NY/cFbixIe4IIr5AZYCe?=
 =?us-ascii?Q?Jv9zP35saQWpZMFVOfV45IXXjtcm4rYHoaqOhjxgGcYkMbP1ttbwnnTAt4Hb?=
 =?us-ascii?Q?SnIvy+WWVzYO2GNUwn0oEyEcjarahRcMjsJ5NoI/nxiVH6V1S3PaPipy+VBb?=
 =?us-ascii?Q?9Jj3SXbo7/fFbsDKSJvnfYtZxSKNki23s+0TzygntAR+uQK2qwhg8cJUVaax?=
 =?us-ascii?Q?f1EE4N04TIlNjMgKrKyuEwCfzyC+DogJNdaRQsq9jLe3SVBiv/xd2RJZ3Bb4?=
 =?us-ascii?Q?w0tgOFU7IvgmNzRfenlrWE7elxZqELbtJ1H3V+0g/bjC/GfRasG2Kw86f3Yz?=
 =?us-ascii?Q?w/IyO0/Q5648R/zRObw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5HlF7mKQgat2zfpUIxmL9sseKgtYX0SBJrWIsJwnDAUF1P5gunSwB5vzbdFh?=
 =?us-ascii?Q?ajYA7yi0hMbYaBAfUZaV6u8sh4p3D25z/AxT09UMyHaiQ7ul+HbpqmqjcupJ?=
 =?us-ascii?Q?W7jmWwMMefyrJ/XdwHVlrxjk4f0M/WicnFLYSnI1K6GpREiS8zVnQUXJbSs4?=
 =?us-ascii?Q?bjzV/4oa+M9dhUPcEdfNUp898VmRfXDFfO99jGljGkDR8kK7dJwWqoxvAc4M?=
 =?us-ascii?Q?D0rfyaVALFYuVrddkbEwHtObegR3MnvqxIUT6sADdt/1L9HunSIrgjattbta?=
 =?us-ascii?Q?6HnQxUFEhSrFgpWmIPqtwikek/05M/md7RIKRnkq6EvwJIn4XvAXqQFor0hL?=
 =?us-ascii?Q?o1vszyIHbiKUmkv/gQQvj78JGQOEWSl0yaWOUpwJ2R9DXOZBqGH4O15dMMZT?=
 =?us-ascii?Q?kApHVSGKxom4WbR6Ndf2HOG3Ipjyedf7zMT7IFq5qgrlHuVSmku1GSLIcSO5?=
 =?us-ascii?Q?2Im0kXmkqpx4Oiw6NeVo9tC2zKpCcFS+ep3fZLNm5NORGfT2ELAiFOAqV9f9?=
 =?us-ascii?Q?ZKJ5Gn7A6hVImLpqNWU4m3A50SpLu3QKZtL1xVkgc4EYseGrLJYukmLL8JS0?=
 =?us-ascii?Q?2x5dzAjqACIwwYJeyWudhQjrdyWPUhJGafqPlh8YLQxjrocYJxDrQU7w1KRF?=
 =?us-ascii?Q?cPMAMLDs0f0eh4iKGnDfhYyC70fh1CYxbLXYFnvcF//LjWZtD0azsOMZ40n9?=
 =?us-ascii?Q?w1JcsxmMV4M/mdWNK/ca+UbE5AaEXH6ygxOfbYR1vYe+dUAp4Ft7He7BIOkd?=
 =?us-ascii?Q?t3CIHNYt8fNi6PYfzRO7TKXLLOQg77dlFyh2s4/bz24Kq8Awc3tQD9FLB+l3?=
 =?us-ascii?Q?aFdNQjDS6kj/NMCJG3HE/Jh/lzngCLzLmJfxmc7znuzsNBktME08vs2nIE/n?=
 =?us-ascii?Q?ZjiFMcYAhXumfW5sHY9tvpuvRQhTnB5hDtque8wsd8nC6xUq4rZHDUr6NQPF?=
 =?us-ascii?Q?Uxjy7bKsTdlVO0UCLqmDnApZaizacJiff5sKqW+GAZLeh9un9jWl+5UG1DuL?=
 =?us-ascii?Q?0g26qdIg/2Luybut6f7fFEFCPvkh2GjDtpmJpk56of8xLgVwSe8Mad8edvn/?=
 =?us-ascii?Q?sGHOhfDJ8f0e6xIolDpJi40zdGx7oKgREmaV/X2n5eEjlrpXCrqdN7xISy/k?=
 =?us-ascii?Q?hMwxEoJsK0rz30mJPBqSIYmwUhuQFSvzpSXX7s3n5KuUC3H8Cj7IUHLtOhj9?=
 =?us-ascii?Q?KU9JbUZ2KSEin22r/U6HLwtA+1zEHP2MpOm3fe6efeW7BMO2eI+HtlSszLif?=
 =?us-ascii?Q?DBKFSnHX2bmS/0HrcIHdouBKMRT++fF3uxIeEJkb/XA1+X0pg8KZk2ytE30b?=
 =?us-ascii?Q?JQzdyqKqxxUaxDELV1A874jfMFzCuuR12Q9gcxaZRUmlDowJfIUM924FTKnz?=
 =?us-ascii?Q?YhZ2QpglyAufo2WM7I7slyeJbCZ3vGCaSGuh0UvOTwO5rtNYD/CtlWaIJXHN?=
 =?us-ascii?Q?xEqz3a0jq4qMiJRu94BtzRmbWVAKzMWOrkqNvWwUJ5I31/OJkmEcskVtYsZ7?=
 =?us-ascii?Q?SSXd0v+czS4ffs/CM/ybozkfKlo4wIAPT80VJDMb5Jv0PJtPFqI9xSUvIahQ?=
 =?us-ascii?Q?JHCYIpoVMNhhOhdh67nujuouTS2G+idDJWl4xxSsxQ4qzLxZ3Kyq+nBsSjIv?=
 =?us-ascii?Q?Tx8HgSqODBSj36IH/FDs0FF+mX9YNkUUORQV7++8N/quO73hTiwcWckfu6kg?=
 =?us-ascii?Q?Yi2IkT7BFE4W1MN9rHq+2A3YY9m1T3B/EvUWDlzuUm+1dsPgfDkF5WyUHX0I?=
 =?us-ascii?Q?Bpf3YCPSKz2T0PiBrfqU4JEAr15S25y6zi7AeXtlJSwdaCa0MP53?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c3146d-c7fc-4aec-5e5c-08de5cadb4f6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 07:37:06.8891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQ+6+pInJJp8vHCLmueNVlBODhCNzvmB+syb3yCT/PuXuBpwwnznXU/uPsjubh9s3x9AkPrDS6inv2N6VFZlzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6300
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8481-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim,valinux.co.jp:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 75F7484E1E
X-Rspamd-Action: no action

Remote DMA users may need to map or otherwise correlate DMA resources on
a per-hardware-channel basis (e.g. DWC EP eDMA linked-list windows).
However, struct dma_chan does not expose a provider-defined hardware
channel identifier.

Add an optional dma_slave_caps.hw_id field to allow DMA engine drivers
to report a provider-specific hardware channel identifier to clients.
Initialize the field to -1 in dma_get_slave_caps() so drivers that do
not populate it continue to behave as before.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dmaengine.c   | 1 +
 include/linux/dmaengine.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ca13cd39330b..b544eb99359d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -603,6 +603,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	caps->cmd_pause = !!device->device_pause;
 	caps->cmd_resume = !!device->device_resume;
 	caps->cmd_terminate = !!device->device_terminate_all;
+	caps->hw_id = -1;
 
 	/*
 	 * DMA engine device might be configured with non-uniformly
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 99efe2b9b4ea..71bc2674567f 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -507,6 +507,7 @@ enum dma_residue_granularity {
  * @residue_granularity: granularity of the reported transfer residue
  * @descriptor_reuse: if a descriptor can be reused by client and
  * resubmitted multiple times
+ * @hw_id: provider-specific hardware channel identifier (-1 if unknown)
  */
 struct dma_slave_caps {
 	u32 src_addr_widths;
@@ -520,6 +521,7 @@ struct dma_slave_caps {
 	bool cmd_terminate;
 	enum dma_residue_granularity residue_granularity;
 	bool descriptor_reuse;
+	int hw_id;
 };
 
 static inline const char *dma_chan_name(struct dma_chan *chan)
-- 
2.51.0


