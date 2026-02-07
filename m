Return-Path: <dmaengine+bounces-8813-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qUR9Bodnh2mGXgQAu9opvQ
	(envelope-from <dmaengine+bounces-8813-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 07 Feb 2026 17:25:43 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0F8106803
	for <lists+dmaengine@lfdr.de>; Sat, 07 Feb 2026 17:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BDCAE300A4ED
	for <lists+dmaengine@lfdr.de>; Sat,  7 Feb 2026 16:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF5B333737;
	Sat,  7 Feb 2026 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="kf1CMJb/"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021121.outbound.protection.outlook.com [52.101.125.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758DE125A0;
	Sat,  7 Feb 2026 16:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770481539; cv=fail; b=TE9/TOZWG0t++2cr2QXp5x915kX1ALZW7Kb4PfVfLeLkCC/+MOVyl0D+Wyrsyi4PGEMZWO5Y4Boj/z1zUzdHjJRVLGO88/CWxmNI4PNswlPYEUGGfu91OO8/Lu3WMkAfJyRhK0UohDe2Inv1J3HCLbOO9IpGPnSmfsQ1BW93ZlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770481539; c=relaxed/simple;
	bh=nSQdv7LcJSY8qJdF1qyrmjFaZAOwILz79IeRC0H+FnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cKIlge9xfw4+cIhM4qV/+brjTnqPCV2YUfLDiTioHMlgToV2ryo9SO13Tpb+XifMWJ6jAoMssRTJoc6V0HnalBD5q+MTZy48DcK9KJaJ37gBXCloUTu3mNPWy8EnS2ONxJb0YkOxtWaZEwujQ8f9EfbYIe+Nn+ncqoCFjb+Hz8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=kf1CMJb/; arc=fail smtp.client-ip=52.101.125.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wDeCtWZai2vDiFBIvrwxduCcbkZqAEOs66bn9ewW+rcbF0txhh9rntXmk30ausSPfc6t0wiWBqoWEybCF5vgMiBnHBxIugmzRMQlrA6yJVjkftAFxNPROJIr8dvX/tmDwXx/yFXJ8xBqNq0/pZA5TicScnIN/kx8ijkoECoIk43QtS+Ag5dprz9vQauWuzVXCvxC2+UUrApk8/X53zZn3MKM/DEJ4NuJFVZu+mdK7r1POIbX6AG+ERhTrsgyEvrjotdwjjp0lxBnCay36mxqvhIQTiW5w5Q9ya4QrIp93Yt1NjOCuT92Hr+sYSsaXX9E3e/L5sG9S+LZ6NPctbScFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uetsxxPiwRuok/LwobeKiXxYqVOq/LsN/hwyH02Wg1o=;
 b=gXjqdunnzunHNwymz8UeTDzvr04OpSw+pbKV0o6nYPlWiZ7nxo5MvbhMpihU4h0ifM43H5nWRPn8h0jqEP7WT8S2qBi46NpMJ+hZ9ZIwUx8/NC2P0HdfpaXC5qGwLLJyHj/Qe323OAsg4nKoNbPGlNe0UgYqkaN840gVVmfmfAf+JNhllIitqGA72eZXBUZsYhPXyPzf7qQB0nlkIONCq8xtYkMuXMLSSOIitA3BIWVTuFLL/HT8vf+bOaKwhLhypeEnXMGHcidSwewX2seLSgAQbpnt/V496G8ufDigkzu3wsQXcZ5jbgTJzT/P/0DLXJlLYYzNja5RiEJgaKyfPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uetsxxPiwRuok/LwobeKiXxYqVOq/LsN/hwyH02Wg1o=;
 b=kf1CMJb/pwUEfh4U6D+bYiW6FbscJlyKoS7hvOaCgxhLTnaletwJeOktl1yf/tpBWmkIIEzlZGb1DzOtLTSDvdm0hufEAWMrCcLgwPbgAvk2OrWNGTWdn5OYLYlt4K/2TFaNFG8n+ZJFgjBfwnx2G9lD7fes6F5pGEI154O2Afg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB3507.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sat, 7 Feb
 2026 16:25:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.010; Sat, 7 Feb 2026
 16:25:34 +0000
Date: Sun, 8 Feb 2026 01:25:33 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] PCI: endpoint: pci-epf-test: Add embedded
 doorbell variant
Message-ID: <avey4i3lwcqt4wsy3y2wjlx7ixo7sqe64hngj2ne6vubl4mjzv@kaksbjkspifd>
References: <20260206172646.1556847-1-den@valinux.co.jp>
 <20260206172646.1556847-8-den@valinux.co.jp>
 <aYY_Ghig9wvnp8Wg@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYY_Ghig9wvnp8Wg@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB3507:EE_
X-MS-Office365-Filtering-Correlation-Id: 806bf085-730a-4b91-4312-08de66658535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|7416014|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PxqwUv7HfSUqI/8n0aoWMEoc5h1Wwaz1AmPKrP6woc+EETMjNzPGARDC9wE/?=
 =?us-ascii?Q?snrgj2DLyP8KZ+Z8mY01TvtXoPVOBYJVxcl5ALZaT5rhnm/Q7Gn7iNqh6Kcm?=
 =?us-ascii?Q?qxz4GG0vfT9U+lMnM398pavZvAhc4067rnJ3o/jCS6ERxmvlk8pZldqPkm5p?=
 =?us-ascii?Q?AGtiILsN4lGRy81c73V3B0DvwKoe78vdnNKRNpQ0n+F8lhw1L+M7nkdx3gPk?=
 =?us-ascii?Q?mv5Dr5mr62G9nYjoSOq7aasKBmk7KxgK+O6OSsGWSyoJde5SH/fRwhBTk0+Z?=
 =?us-ascii?Q?Op4ZQpGNttNZcMOhZwOcipobNM2JrXYpxxCB6b+7CDyWUSdmt4fYjQk2KHam?=
 =?us-ascii?Q?SNMFJqpx2a0cA+ez7m8WM53v5ZDn9XNHnFsdi4j7hWvOfyYksDroAQn2rukT?=
 =?us-ascii?Q?CMCzsPlnjcxwU6bCwfJeItjPLBwcQ/ckUDnT8RiAlceAxEhDp0/8/glii6VL?=
 =?us-ascii?Q?4paSn0gUGW29xsHJcko3D8RqK2y3017ilqhlcKTEn0hdjn0acrHMba/xnKVv?=
 =?us-ascii?Q?sRyHWvnukLi6na3cw2wCIP+82HKtveiX+rpCrmOfNbUKFx2sZ9/N8XqYX4wB?=
 =?us-ascii?Q?x/TxOndd2x8OS8HivYtj5VicViQNO8CHxqXNHHfvPQbQ1saJIqVOTAIoqZ43?=
 =?us-ascii?Q?zqwvpVwZok97CKC8s1Wpb1uEnTCWLW8voa5A7X+BXkgOmCW34TZ6vLlVz+hQ?=
 =?us-ascii?Q?rSG3mQaPL3d2TDMtw+YDKFe69AbsGQlzVdkqMgLx9wHipgBC6AgRNiDaSsMF?=
 =?us-ascii?Q?CGD4ILwMU/wqHMNeq/lvk87Qwj8PAgWm5SPU2mo8BJfFJ0UuDaRBVDAYTO/6?=
 =?us-ascii?Q?j1Z1KD0rVcjjP1LeB7kGm04htv/JxMHr1hvHoq1o3m0OHD9hgznG/9L/G7Hx?=
 =?us-ascii?Q?/lP2hNAQPcVwVJD3dSDObxTxgjRqvZtgZpjth5fZQQLiUIsq95+wHFUQQlCt?=
 =?us-ascii?Q?Dk8H/8OSTDqSc11VFI9Fbne7QK4m1vTaLBPAgWYKT1qBFbRrAr8VLU66ewKV?=
 =?us-ascii?Q?72AOuUHNGTrR5VbwkicvCUzFIfb+DLawQashEestmfiWawzQnQCn5gL48yXZ?=
 =?us-ascii?Q?UnnIoJU7/vs0rz8P1dbwlDENmP7D+ROrmoA0l56zWdqpotM0VfNlFZrfzCcj?=
 =?us-ascii?Q?XOslbkp3TsDcChu7+NHfxfzbu+QkfHyCJv7JHwmdD+l+VdQqo6qtM3C/uNLD?=
 =?us-ascii?Q?CQ/QVSZqBEtkXRtrvhrHjl1ae3Ku0v9Fh30ivSnqhdNiReLkaX6kPJDDYlZW?=
 =?us-ascii?Q?7BZxElgUv6pzGBnyBXAW+UMUjBwAd/ZqsS2/yYjjaSHTZyhkoqLav72Ok8Tl?=
 =?us-ascii?Q?w9Nsx5GWm9fF7UswJGbNMHG9eREI1OvtJqKl8zrwf0RWJtBbOrb0+6e2qSYx?=
 =?us-ascii?Q?ygiph/tg1jE0qG7AQ9AmfnLJRiHqtd6JOZz13QIDRtZDELnKdlHG5aqdRv7A?=
 =?us-ascii?Q?SCOiJ8G8dm0XN3hdW735SzVo8HV5hkdk3F0q+xnP5kcRTPaXUzp3vRuq8/4Y?=
 =?us-ascii?Q?JIsgpoRzjjHw22XVk0Zz17yhfzPnSnP/UBgZSe1ejR+rHaOukz40mj4zMLZI?=
 =?us-ascii?Q?SZDLYoQo7QdI6rnOK3kzG1++IG6+Xc/HaAuct6hniisJ//JNGLFFhUNPbfZD?=
 =?us-ascii?Q?d+RPtzioA78wAHzBIgHct9Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(7416014)(366016)(27256017);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ol3cbQdUaW0W2XvNX21v01Ig0s94ynH4W2lW4SHRU4JjpIIi8UdGUc0CxMr9?=
 =?us-ascii?Q?obnttvZxcPeTWtGd6rBMhQAYls4WTHZKgErPZcupW+QWeAiqqp2JgfZOUsiZ?=
 =?us-ascii?Q?2cZNLVn0mq5p14KgbQ8nHkL3C0scC2TisqLicmJgUV03+MqYAGe3G7gPqEOu?=
 =?us-ascii?Q?d+FhjnLDCkvejfVkWN48RYIOtaQ8aQqXNqMnW++cDvmAqTCGBryqEq0HdvYW?=
 =?us-ascii?Q?+vD8bJHsOaSFW3OoHC4laCogSCjTxNXwK390bFj4wSRIvgdmF405V5JXOWPn?=
 =?us-ascii?Q?py8d9BQ+9oZraJ7gmSMWl9isDge/sNB28UgBaTsB2rGmeHqfxq6Kv0YXnY/4?=
 =?us-ascii?Q?CtEURz+nJfuBofd6ggV+PAHQ1nnTag6p6wHQRpxOiqKrVhLE1Q9arHatRA94?=
 =?us-ascii?Q?9IGNHUSGVHlh8XjYI3kCN4SsBhF0jKyD0r/4VLiRYeb/SQ6MgoUBP9MxHOB5?=
 =?us-ascii?Q?Ty7sUqYM7k4jO0vYnhBeDTwUDqx1hZMUjfT4fli2U9po11pRiEG2BAOp0FGg?=
 =?us-ascii?Q?Bkow/Cqre/5sQjBhhJNH/KYS0eR+Uthpf8hM9d9t9ga+tPl+nXaPWWpTsaB/?=
 =?us-ascii?Q?fP6fxRi43TVznbqGg/gSm3W0WUZK8N37m5i1rCVYDvLIo9WacQceu3jTrZNg?=
 =?us-ascii?Q?Pndtnx77N2REyYNkpTSi4VIdRV7gU+1hvaknLR2p4DV6obKe6+M8XU6umJL/?=
 =?us-ascii?Q?JvoV4B+MHOeU5ACJpx+LHpfZwQUAdjCdvv30qEva5AgCAXFbpuRo7okauT68?=
 =?us-ascii?Q?ZwX7WWJ9YRG+bqQNERcjtV+l/zyZR8OFARqvObw44KCiEoVeEt2Q0kH8ljFQ?=
 =?us-ascii?Q?9hPI26B62fTr/ClmqJ/bV6OLLukGy+jASkxOLltvNUWlmYQ/KaWDJ8ngKLY5?=
 =?us-ascii?Q?HkpV4TkFHaoFvdrJ0/MQ5Dir8OO7mV2KsMzAsfKQ3Y1nbnWHtvdI2oVHgmLQ?=
 =?us-ascii?Q?O38QWhNe2km312UmJcw6fQ17B0C+TquNH01+cbQGGC+iDoEsGFb2I5XTWsd0?=
 =?us-ascii?Q?VEpXXlBvHvVCUecqTt2fN8r6Ah8rGRyICY24OMbbDOx59k+5QMq/bg+wjXVR?=
 =?us-ascii?Q?N+QQUSxyBtC5u0cqXmFvga98BhRnjwkvbZGyLi+OUeJIc1JMNWTeKvIIdF5M?=
 =?us-ascii?Q?ORXBR85LdkBZa9jgymA25NzAKdl+rCA1bJccY3MFz+PPgZncqAksZQzHONTP?=
 =?us-ascii?Q?1iMGp5d9qOBsz/6QWHCFr0urmTJ2A+kL5wu+4ZHaj3V76G+dx38MuIVPoV5f?=
 =?us-ascii?Q?SNYh8uxo/X/bKJgKKU176jNCznEPfotUpDiQ5Uqf9ndj1cuRO3NL4eKly1xr?=
 =?us-ascii?Q?YC95xotZjrNzDa26MJG5SHlTTori+pkEO2nnzegAU5aftje7EAkVC8Y09f9v?=
 =?us-ascii?Q?rH3FZ1Dpa9cZJV7Mu7KJ/PtOVxxwUSlmgJ1xZzm4wFeqX8XT/1s/8UJwDUPB?=
 =?us-ascii?Q?peH2IK+aPlYHKLO0iBvAbmsRz9P7beI7NDO0Jz17Vvx0J3TdUW2EXG2D3f9B?=
 =?us-ascii?Q?7Yrk4/u2AvI7c1npqyFBSxSLfqIiUsR6ZkxlL3rqqhtkbgtAv0BNS8Nhl6tG?=
 =?us-ascii?Q?fQsRxcSLdP+v4scyZV/uvckUUY0yHMmV3DAIyxjf5nwONdunysLEj74sWu8c?=
 =?us-ascii?Q?NirJHEHL8Hc9X9o/1oFOUj5mFOaVdDg/zR9bCg1nCS4EOafpEaiVPwBxW/5h?=
 =?us-ascii?Q?pOq/V5nquu2w9/ZVtUpOwHz5DQyhTXb4qXGl/Ux9N8IszIjRzMT/L4M1tnHh?=
 =?us-ascii?Q?+AdlYyyfvL0cyVSKKWmVOJI2h/JENqhciGUqikqHl6WhsdpGjJf4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 806bf085-730a-4b91-4312-08de66658535
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2026 16:25:34.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OADceYdwXejhZkdDEQ+/FOecRm0lXKYvoo1yip1YvAbqeFGEWc9tmOWxk/U8GYYCHBqG/2z3QmdAucLHq6YcOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB3507
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8813-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F0F8106803
X-Rspamd-Action: no action

On Fri, Feb 06, 2026 at 02:20:58PM -0500, Frank Li wrote:
> On Sat, Feb 07, 2026 at 02:26:44AM +0900, Koichiro Den wrote:
> > Extend pci-epf-test with an "embedded doorbell" variant that does not
> > rely on the EPC doorbell/MSI mechanism.
> >
> > When the host sets FLAG_DB_EMBEDDED, query EPC remote resources to
> > locate the embedded DMA MMIO window and a per-channel
> > interrupt-emulation doorbell register offset. Map the MMIO window into a
> > free BAR and return BAR+offset to the host as the doorbell target.
> >
> > Handle the resulting shared IRQ by deferring completion signalling to a
> > work item, then update the test status and raise the completion IRQ back
> > to the host.
> >
> > The existing MSI doorbell remains the default when FLAG_DB_EMBEDDED is
> > not set.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> 
> Can you change pci_epf_alloc_doorbell() directly? Let it fall back to
> edma implement.

Thanks for the suggestion.

Yes, while I think doing so would require some extra care and constraints
for the users (i.e. the pci_epf_alloc_doorbell() -> request_irq flow).
Also, separate testing would no longer be possible, but I think it's ok,
because choosing the "fake irq" when a normal MSI doorbell is available
would not be very useful anyway.

For the fallback case, the interrupt source is not a normal MSI doorbell,
but a level-triggered, shared platform IRQ. Due to that, the caller needs
to know how the IRQ can be requested safely (e.g. usable IRQF_* flags,
or whether a primary handler is required for request_threaded_irq).

I think we need to expose such hints via pci_epf_doorbell_msg by adding new
fields (e.g. doorbell type, IRQ flags to be OR-ed), and have
pci_epf_alloc_doorbell() fill them in, rather than completely hiding the
fallback internally.

Let me send v5 accordingly. Please let me know if you see any issues.

Koichiro

> 
> Frank
> 
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 193 +++++++++++++++++-
> >  1 file changed, 185 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 6952ee418622..5871da8cbddf 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -6,6 +6,7 @@
> >   * Author: Kishon Vijay Abraham I <kishon@ti.com>
> >   */
> >
> > +#include <linux/bitops.h>
> >  #include <linux/crc32.h>
> >  #include <linux/delay.h>
> >  #include <linux/dmaengine.h>
> > @@ -56,6 +57,7 @@
> >  #define STATUS_BAR_SUBRANGE_CLEAR_FAIL		BIT(17)
> >
> >  #define FLAG_USE_DMA			BIT(0)
> > +#define FLAG_DB_EMBEDDED		BIT(1)
> >
> >  #define TIMER_RESOLUTION		1
> >
> > @@ -69,6 +71,12 @@
> >
> >  static struct workqueue_struct *kpcitest_workqueue;
> >
> > +enum pci_epf_test_doorbell_variant {
> > +	PCI_EPF_TEST_DB_NONE = 0,
> > +	PCI_EPF_TEST_DB_MSI,
> > +	PCI_EPF_TEST_DB_EMBEDDED,
> > +};
> > +
> >  struct pci_epf_test {
> >  	void			*reg[PCI_STD_NUM_BARS];
> >  	struct pci_epf		*epf;
> > @@ -85,7 +93,11 @@ struct pci_epf_test {
> >  	bool			dma_supported;
> >  	bool			dma_private;
> >  	const struct pci_epc_features *epc_features;
> > +	enum pci_epf_test_doorbell_variant db_variant;
> >  	struct pci_epf_bar	db_bar;
> > +	int			db_irq;
> > +	unsigned long		db_irq_pending;
> > +	struct work_struct	db_work;
> >  	size_t			bar_size[PCI_STD_NUM_BARS];
> >  };
> >
> > @@ -696,7 +708,7 @@ static void pci_epf_test_raise_irq(struct pci_epf_test *epf_test,
> >  	}
> >  }
> >
> > -static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
> > +static irqreturn_t pci_epf_test_doorbell_msi_handler(int irq, void *data)
> >  {
> >  	struct pci_epf_test *epf_test = data;
> >  	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> > @@ -710,19 +722,58 @@ static irqreturn_t pci_epf_test_doorbell_handler(int irq, void *data)
> >  	return IRQ_HANDLED;
> >  }
> >
> > +static void pci_epf_test_doorbell_embedded_work(struct work_struct *work)
> > +{
> > +	struct pci_epf_test *epf_test =
> > +		container_of(work, struct pci_epf_test, db_work);
> > +	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
> > +	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
> > +	u32 status = le32_to_cpu(reg->status);
> > +
> > +	status |= STATUS_DOORBELL_SUCCESS;
> > +	reg->status = cpu_to_le32(status);
> > +	pci_epf_test_raise_irq(epf_test, reg);
> > +
> > +	clear_bit(0, &epf_test->db_irq_pending);
> > +}
> > +
> > +static irqreturn_t pci_epf_test_doorbell_embedded_irq_handler(int irq, void *data)
> > +{
> > +	struct pci_epf_test *epf_test = data;
> > +
> > +	if (READ_ONCE(epf_test->db_variant) != PCI_EPF_TEST_DB_EMBEDDED)
> > +		return IRQ_NONE;
> > +
> > +	if (test_and_set_bit(0, &epf_test->db_irq_pending))
> > +		return IRQ_HANDLED;
> > +
> > +	queue_work(kpcitest_workqueue, &epf_test->db_work);
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
> >  {
> >  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
> >  	struct pci_epf *epf = epf_test->epf;
> >
> > -	free_irq(epf->db_msg[0].virq, epf_test);
> > -	reg->doorbell_bar = cpu_to_le32(NO_BAR);
> > +	if (epf_test->db_irq) {
> > +		free_irq(epf_test->db_irq, epf_test);
> > +		epf_test->db_irq = 0;
> > +	}
> > +
> > +	if (epf_test->db_variant == PCI_EPF_TEST_DB_EMBEDDED) {
> > +		cancel_work_sync(&epf_test->db_work);
> > +		clear_bit(0, &epf_test->db_irq_pending);
> > +	} else if (epf_test->db_variant == PCI_EPF_TEST_DB_MSI) {
> > +		pci_epf_free_doorbell(epf);
> > +	}
> >
> > -	pci_epf_free_doorbell(epf);
> > +	reg->doorbell_bar = cpu_to_le32(NO_BAR);
> > +	epf_test->db_variant = PCI_EPF_TEST_DB_NONE;
> >  }
> >
> > -static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> > -					 struct pci_epf_test_reg *reg)
> > +static void pci_epf_test_enable_doorbell_msi(struct pci_epf_test *epf_test,
> > +					     struct pci_epf_test_reg *reg)
> >  {
> >  	u32 status = le32_to_cpu(reg->status);
> >  	struct pci_epf *epf = epf_test->epf;
> > @@ -736,20 +787,23 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> >  	if (ret)
> >  		goto set_status_err;
> >
> > +	epf_test->db_variant = PCI_EPF_TEST_DB_MSI;
> >  	msg = &epf->db_msg[0].msg;
> >  	bar = pci_epc_get_next_free_bar(epf_test->epc_features, epf_test->test_reg_bar + 1);
> >  	if (bar < BAR_0)
> >  		goto err_doorbell_cleanup;
> >
> >  	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> > -				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> > -				   "pci-ep-test-doorbell", epf_test);
> > +				   pci_epf_test_doorbell_msi_handler,
> > +				   IRQF_ONESHOT, "pci-ep-test-doorbell",
> > +				   epf_test);
> >  	if (ret) {
> >  		dev_err(&epf->dev,
> >  			"Failed to request doorbell IRQ: %d\n",
> >  			epf->db_msg[0].virq);
> >  		goto err_doorbell_cleanup;
> >  	}
> > +	epf_test->db_irq = epf->db_msg[0].virq;
> >
> >  	reg->doorbell_data = cpu_to_le32(msg->data);
> >  	reg->doorbell_bar = cpu_to_le32(bar);
> > @@ -782,6 +836,125 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> >  	reg->status = cpu_to_le32(status);
> >  }
> >
> > +static void pci_epf_test_enable_doorbell_embedded(struct pci_epf_test *epf_test,
> > +						  struct pci_epf_test_reg *reg)
> > +{
> > +	struct pci_epc_remote_resource *dma_ctrl = NULL, *chan0 = NULL;
> > +	const char *irq_name = "pci-ep-test-doorbell-embedded";
> > +	u32 status = le32_to_cpu(reg->status);
> > +	struct pci_epf *epf = epf_test->epf;
> > +	struct pci_epc *epc = epf->epc;
> > +	struct device *dev = &epf->dev;
> > +	enum pci_barno bar;
> > +	size_t align_off;
> > +	unsigned int i;
> > +	int cnt, ret;
> > +	u32 db_off;
> > +
> > +	cnt = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
> > +					   NULL, 0);
> > +	if (cnt <= 0) {
> > +		dev_err(dev, "No remote resources available for embedded doorbell\n");
> > +		goto set_status_err;
> > +	}
> > +
> > +	struct pci_epc_remote_resource *resources __free(kfree) =
> > +				kcalloc(cnt, sizeof(*resources), GFP_KERNEL);
> > +	if (!resources)
> > +		goto set_status_err;
> > +
> > +	ret = pci_epc_get_remote_resources(epc, epf->func_no, epf->vfunc_no,
> > +					   resources, cnt);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Failed to get remote resources: %d\n", ret);
> > +		goto set_status_err;
> > +	}
> > +	cnt = ret;
> > +
> > +	for (i = 0; i < cnt; i++) {
> > +		if (resources[i].type == PCI_EPC_RR_DMA_CTRL_MMIO)
> > +			dma_ctrl = &resources[i];
> > +		else if (resources[i].type == PCI_EPC_RR_DMA_CHAN_DESC &&
> > +			 !chan0)
> > +			chan0 = &resources[i];
> > +	}
> > +
> > +	if (!dma_ctrl || !chan0) {
> > +		dev_err(dev, "Missing DMA ctrl MMIO or channel #0 info\n");
> > +		goto set_status_err;
> > +	}
> > +
> > +	bar = pci_epc_get_next_free_bar(epf_test->epc_features,
> > +					epf_test->test_reg_bar + 1);
> > +	if (bar < BAR_0) {
> > +		dev_err(dev, "No free BAR for embedded doorbell\n");
> > +		goto set_status_err;
> > +	}
> > +
> > +	ret = pci_epf_align_inbound_addr(epf, bar, dma_ctrl->phys_addr,
> > +					 &epf_test->db_bar.phys_addr,
> > +					 &align_off);
> > +	if (ret)
> > +		goto set_status_err;
> > +
> > +	db_off = chan0->u.dma_chan_desc.db_offset;
> > +	if (db_off >= dma_ctrl->size ||
> > +	    align_off + db_off >= epf->bar[bar].size) {
> > +		dev_err(dev, "BAR%d too small for embedded doorbell (off %#zx + %#x)\n",
> > +			bar, align_off, db_off);
> > +		goto set_status_err;
> > +	}
> > +
> > +	epf_test->db_variant = PCI_EPF_TEST_DB_EMBEDDED;
> > +
> > +	ret = request_irq(chan0->u.dma_chan_desc.irq,
> > +			  pci_epf_test_doorbell_embedded_irq_handler,
> > +			  IRQF_SHARED, irq_name, epf_test);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to request embedded doorbell IRQ: %d\n",
> > +			chan0->u.dma_chan_desc.irq);
> > +		goto err_cleanup;
> > +	}
> > +	epf_test->db_irq = chan0->u.dma_chan_desc.irq;
> > +
> > +	reg->doorbell_data = cpu_to_le32(0);
> > +	reg->doorbell_bar = cpu_to_le32(bar);
> > +	reg->doorbell_offset = cpu_to_le32(align_off + db_off);
> > +
> > +	epf_test->db_bar.barno = bar;
> > +	epf_test->db_bar.size = epf->bar[bar].size;
> > +	epf_test->db_bar.flags = epf->bar[bar].flags;
> > +
> > +	ret = pci_epc_set_bar(epc, epf->func_no, epf->vfunc_no, &epf_test->db_bar);
> > +	if (ret)
> > +		goto err_cleanup;
> > +
> > +	status |= STATUS_DOORBELL_ENABLE_SUCCESS;
> > +	reg->status = cpu_to_le32(status);
> > +	return;
> > +
> > +err_cleanup:
> > +	pci_epf_test_doorbell_cleanup(epf_test);
> > +set_status_err:
> > +	status |= STATUS_DOORBELL_ENABLE_FAIL;
> > +	reg->status = cpu_to_le32(status);
> > +}
> > +
> > +static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> > +					 struct pci_epf_test_reg *reg)
> > +{
> > +	u32 flags = le32_to_cpu(reg->flags);
> > +
> > +	/* If already enabled, drop previous setup first. */
> > +	if (epf_test->db_variant != PCI_EPF_TEST_DB_NONE)
> > +		pci_epf_test_doorbell_cleanup(epf_test);
> > +
> > +	if (flags & FLAG_DB_EMBEDDED)
> > +		pci_epf_test_enable_doorbell_embedded(epf_test, reg);
> > +	else
> > +		pci_epf_test_enable_doorbell_msi(epf_test, reg);
> > +}
> > +
> >  static void pci_epf_test_disable_doorbell(struct pci_epf_test *epf_test,
> >  					  struct pci_epf_test_reg *reg)
> >  {
> > @@ -1309,6 +1482,9 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
> >
> >  	cancel_delayed_work_sync(&epf_test->cmd_handler);
> >  	if (epc->init_complete) {
> > +		/* In case userspace never disabled doorbell explicitly. */
> > +		if (epf_test->db_variant != PCI_EPF_TEST_DB_NONE)
> > +			pci_epf_test_doorbell_cleanup(epf_test);
> >  		pci_epf_test_clean_dma_chan(epf_test);
> >  		pci_epf_test_clear_bar(epf);
> >  	}
> > @@ -1427,6 +1603,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
> >  		epf_test->bar_size[bar] = default_bar_size[bar];
> >
> >  	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
> > +	INIT_WORK(&epf_test->db_work, pci_epf_test_doorbell_embedded_work);
> >
> >  	epf->event_ops = &pci_epf_test_event_ops;
> >
> > --
> > 2.51.0
> >

