Return-Path: <dmaengine+bounces-8884-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA4AIgunjGnVrwAAu9opvQ
	(envelope-from <dmaengine+bounces-8884-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 16:58:03 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 007D1125E4C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 16:58:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1E13F300A50D
	for <lists+dmaengine@lfdr.de>; Wed, 11 Feb 2026 15:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC869325726;
	Wed, 11 Feb 2026 15:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NDgBTnrS"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020109.outbound.protection.outlook.com [52.101.228.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260ED32548D;
	Wed, 11 Feb 2026 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770825479; cv=fail; b=TcZNCVa6aL5cpwro7HuVeqy/008H7OSVx2emS5u+QedEc+hguKohfIcYxGpVTcRPmfuWVE05H0WCFXyPDwrDbiyL26YNcmRAyHXJMRZBU3e1UzvJ9ULXzm82xUkqt4aCTWASouR80G14liAVLdEv0zbwXgKKYzg/qZ3twZY/HTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770825479; c=relaxed/simple;
	bh=Faye775N4XAogcE1VLxhLviICbmFd32hgSB4zy3SGgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aVeqdGsm1A8r/gdrt6FmOhIgT7Ae7pG2h5SLmSxl8nt2n7+KEKDHkUnnEYq99RoSBDJOp3cpKue/n/buD3yKKKmGGWe+YiH1cNkBUtG6MDxzJ3H+lkIsuU8VnmWLhCsdIHGbSlp3PFfqt/dR7hkUp5jRPTSvkP1wZfP35QZNbwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NDgBTnrS; arc=fail smtp.client-ip=52.101.228.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6s1BtczH3bF9UhVQDUSOpsuFZ5xUtNe+yp7MNDFO5+hzPTG2N0gFkBWIDi1reoPuCSLHoLOLNnZE3QtNGrJTluJ4mzg0WP0g2hvsu4N11af05OW0ljr53MjMl6SLUHoBZsqOzAYh7gsjTUz7BLukOgiOk+5RQxoW/I1yBPYbyRSuiiEawNDqQWln1UBalb1MHsQIuzzuF2cd5Zs2dFHd7QB3k9/y8R7xCqs/q5ZoAl23Smu+L18tsBVX24cn+T/qm6sUUbnv977qcZz5VxWagoobsx3sRc/kRiGGWBvVaxfK7OlzwE8gfOyXtSvrO/kPsUZPFNlK3I38tpHU82fqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4nmCq3EDRnwJl05bhcPRgejAlSw7pewjl9mHhBP1tzA=;
 b=GcMaXmIzOSHuAjIzKDBpoGqhoo6dS8rVNkPxmbsjAasz84wYqZFHF4WIz6YXR8Qu4ua6eT/j+6kuJ0O/q7MjvKjezV32WDlLoNnu/IFFCCdbYiTgxASByhhbSeoLPZtz6SIMz8UVd00WG1W6xdP6WNuwRYyfuitqi9K6GsHQpl35tV3LOXk2cT00gtqyEwUHOc6yqYhdtGz7XgkG4gwTHox70EwXSgCTJBQ+q7um6722mSWP0JwfpyPJttfoDME+mNVHEM0gabS/uH4KQpH8DWj2wI2VOu2XbfwufN+7Kue67+cu1O9u2rQ8OaYUzcJ9215BduTtQMlWgOCTZAPpVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4nmCq3EDRnwJl05bhcPRgejAlSw7pewjl9mHhBP1tzA=;
 b=NDgBTnrS1gujrNfUkvMAy+j/PAHrAYHNnieq9wP9GCDEMiHZ830YgmO904IvW8vYCEWHRk2Dj/a1KKL0g24dnX9tYteB+iwAcyjieZZNUPjU3pWtzPC6DLRcZ+tvB26mr60amlgNXuat/88c2XbUwg2aJu4s3ukQSMdRyh4HCzQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB3720.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:3f4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Wed, 11 Feb
 2026 15:57:54 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.008; Wed, 11 Feb 2026
 15:57:54 +0000
Date: Thu, 12 Feb 2026 00:57:52 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Niklas Cassel <cassel@kernel.org>
Cc: vkoul@kernel.org, mani@kernel.org, Frank.Li@nxp.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, kishon@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/8] PCI: endpoint: pci-ep-msi: Add embedded doorbell
 fallback
Message-ID: <23p74hldtvi2xn6aza2rc6kh5hidzutu46ugzt6mzliyjzylka@k5gchw3amcig>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <aYsjfTtA0EsXwh69@ryzen>
 <2lii3hhzie5n2kkoan7hvittid2bo2jgvkb2fndyscc527xglp@dubt3ie7exdq>
 <aYtdEnZM5mnmcgtY@ryzen>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYtdEnZM5mnmcgtY@ryzen>
X-ClientProxiedBy: TY4P301CA0112.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37b::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB3720:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d2008b8-365c-423d-119b-08de698650ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lEeavvT0rfXOCYbblwl/NqG0rgKsqdmCGrrNrkYExmqH1D/JIbBI6NPdNOXL?=
 =?us-ascii?Q?mGk2CHbAkvvzEpLWhxaXB4YYJUL/MFntA8FWP8+QYkCzub5gPjp5C6AHJaQ4?=
 =?us-ascii?Q?pCU6mEbwgzmFmqFk6m7RJN6SWE3VM+9ATEiI2B71snSAdlxeTv+RUfE3amcj?=
 =?us-ascii?Q?O5/BXGZTb9L6ewDaNjeAe+AUFTtFEgwL3GJ1n/vo79HoIQ5fkP+f7UCj71uG?=
 =?us-ascii?Q?TX0KO22k2h5tP5I082W8KJz6x7sU8R5bwLm/Djg26ovLhu6gc3a/mjC/1hHc?=
 =?us-ascii?Q?3SN/APkAdPysd4jKllkM10zNTjXG3FTcbddQ+BowGZSH6OUI+d9MF8SAxwxB?=
 =?us-ascii?Q?M5L+7pGlKoklYa2mWVd5W0OO+x1MNgE6PKVONxG2ba0yWzkQ7zsTQYj7PkRv?=
 =?us-ascii?Q?AeWtcuGNCa8zTXapzTvTCgKAPlAFdarM1Lt8BRcfRZ5tv/vMjXORLb0vphiY?=
 =?us-ascii?Q?57GfjhEDwc8Zapt4qthAldkGiWuY78uflPgbv6yYToaR4Jcku8BcW1j1ks5G?=
 =?us-ascii?Q?Nxv8qXUo5lbiABoUlW5B2VXB/FaSNdKKcjGAz4JUoQVMwm6PfvgFpEQDyV5x?=
 =?us-ascii?Q?JFG4KM7xJ1rjrUly40GRcOQ58oLpC4RZmO12IRbo2X5tp//iUag8tSIHxEgp?=
 =?us-ascii?Q?ZgIIuFWmTlZwxPu3M8K3i11SyQkao/PTrEOIRCWXzr52CgWi6bKC4O43D4zE?=
 =?us-ascii?Q?WBAthHtGPDU37lw/rLsonm+16+uEb3nmX+J1VC1egZ5sAXKkBVlvI54xhYT6?=
 =?us-ascii?Q?5nOziJZYOw56MAMuyLkPKvsXRFyHMm6cd4+CxU3R/CRUG6KCapnsnNPRj5Hy?=
 =?us-ascii?Q?WDxwiC1fKyhWxE0vb0bOCsX2Ijgyl6NL3sFOqMAlPu/X75CshRZSxZK+LDel?=
 =?us-ascii?Q?6bes19F0zuDNMHDpvAaxXo0isHR/LR0QEkspQU5VnlMm9hWKrvQ+cL115imm?=
 =?us-ascii?Q?qm/kykCQi0jEOZ5jDLfY9eoDdHqDByzYEs9aqp1R42R7TqIkgNUazT+eRBrv?=
 =?us-ascii?Q?zrgTKeCbn5Z1bODbTrR96y2UrkHcIG5hySc25WBKn4BkCEs46GfSj+bnmkp8?=
 =?us-ascii?Q?cPE/xfk0PuWj97YnGEasRHDU5LMbdiCfIpkFttxzZasLh9/j2OdTtxcQZF2j?=
 =?us-ascii?Q?+ICfcGDSipdKnLAdnaACUPxoFeql4+tgOY4+k+zrzSYDKjY0l03RvtzarJtn?=
 =?us-ascii?Q?kDLB82YzTmQpfTCKulSVUZJ2i0nXWeKHD10xpiv0zwNAmg0cKtE5MitOQ6fa?=
 =?us-ascii?Q?v3weaWJKCJUFt+Xg1029ND3XD2yhj7wqnYLbawd47CG3+NK+N/qCUrDcSqDT?=
 =?us-ascii?Q?JZJxtdrbEyIyRWEsmq8X7K8+CBjQLrAKPq0SPgBv8hIffnGAetOwBjNYF0nc?=
 =?us-ascii?Q?eD6ua8oi3vs1LpKcIENihN/Pp3iXNnSI3wqN00x7NS7oJ6/RRN+XlnZxhMuX?=
 =?us-ascii?Q?e4jgYOpFczsAKdWZd8+wvfV/XPYemVtaX+fpg3N60uNVZswZz3Y6c75jZRE3?=
 =?us-ascii?Q?usgYszUz+59KvjEL4k9+Ps0BxAmD/RwMGr52?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tQFr0k5SmARj8pHBkSs8H9dz3xQ13BlElBlZR5iYQuXgKq5N2uP+gp1ZFvz9?=
 =?us-ascii?Q?al5RuFDYAeMLR98qxYyyDgusaUt6uZ5nJAfTNhu0GJhXN+gx9GH2zlSTSSK/?=
 =?us-ascii?Q?QZFpEsQxgvBEArNkNkzfedgP0IODA4dGf34N1+g5fyalJwNwkqd+OYwKidbF?=
 =?us-ascii?Q?2MkMS6M5KaUfCejFHOT5hkJcEGpjTevcVA5UUF57p4xzzLzQjLtXEqgtILER?=
 =?us-ascii?Q?chBLIDHjuOxcMlXj1HWH8amkC/PkTRh5TRfii/JjiQqpMbUXGKGPRHANhBOh?=
 =?us-ascii?Q?4tgGnbYB1bZfxGYQZ/0nwNAE29Hy1XTYURHY7qkAqTuYn0s0s+QA9/shRh8E?=
 =?us-ascii?Q?snFlIMy6HqRn1bUrZFqrI17MJB7ZvbOcZhvO2PHMA38jsRmXI8z0y2U9ERSG?=
 =?us-ascii?Q?K5sC7VXSuQRbAj+RyREGHYlbQvDq94rccuRhN6/YCCKN4/s3mHxUVN1jdcct?=
 =?us-ascii?Q?YQYBZIj3BbZjjXA3DkEeAAaY2nCswpcB/QTviMPqPfyKY+8qc+9f5MMlhE6p?=
 =?us-ascii?Q?2mUIi5OSgoe4HH5G7vFvhIJOdr12qqO76d99jtK+ao//VIVSUq4rycojzUpi?=
 =?us-ascii?Q?brGXzLPSEUqT9iJg6cuaEWV7I08/DMTVZZ3Rim/inI38+7xcHHzzzSbs0UFR?=
 =?us-ascii?Q?3KCFifoFstJ27azTsv9BfoxFv9C5tAaD4y4kfL4FZMvqQNZ4ymPISbv5zC7E?=
 =?us-ascii?Q?uQLcU2Fz02tcvQInhSZn/n4Acfvx6eLFmuoiwyXBZqEZqZk1/BB4X3hErLer?=
 =?us-ascii?Q?ZK3MNSvtnRDIF+gGS7f8w9Y2Z/CfiXMd2Ghm4MTIwieF60vxNIVTvwppZnmW?=
 =?us-ascii?Q?yzWz9PKs0zAf/5YkU6QFbB79ZNZJoRaAPnZJFTYPJW9HxGgD/nh3AM3mjdK+?=
 =?us-ascii?Q?tATkZnSJnTEjby8WRouuniZ3rCzsHyyp+r3STnM/l3i06r89VmgG5uz1UVcp?=
 =?us-ascii?Q?720jIWbqeX9FRUdtHN2MS5WjOHlXAeS5EBzhOUA5zjZdWX0YMlF2C+EW7eA2?=
 =?us-ascii?Q?KA3uFHbKUKCDhm+wBGCB4nweEe6vOmlPXihB7EHGNHWTM/Y0DnmDkPfZ3oFC?=
 =?us-ascii?Q?pNSXD2A2QSPPWcR+/B2SaJnUz6rn1Q0sQxcyxe5oC6Sh3OwiJrhuYEIWB1Sx?=
 =?us-ascii?Q?F6bg8CJjWFrw00HsdrcSfH460jjsWZUXbOL+cl0L+rC2A9DA07zp35GOgXeM?=
 =?us-ascii?Q?58Kiu+8qKGVYUQThqy7Sd6olzY1BJ009Nbugid01BQKj6gAVE5G34WVsxSq3?=
 =?us-ascii?Q?ysXz8iELff7ATV0w0ekJHw3GEBGNwFfx4bwevs8VVOOS52Vf47eDKwlxWXN5?=
 =?us-ascii?Q?K9HCA2PsRI+4wdMuTAh2qR5EWS0qblbibk4zsa0D5s7L/XYEY+7PWYQfQD0s?=
 =?us-ascii?Q?hKNpPnYBUXhZ/UbeBhdEDjOaEpA8sc1v5qCcIo+oVGNarh0A6HxM9to87EpN?=
 =?us-ascii?Q?pXJsMpfww7FhogLOG1n4SJ0toAB3mGLStiTJJ6bWCufbyFwWuUXkSbq04CHA?=
 =?us-ascii?Q?TRnhdkmzsjaH2lIqDNGm+XtBJ6EJkdwemBmZ0X07yLrsVjKsInv4bbiOtYPQ?=
 =?us-ascii?Q?TWSDhVmY/uzAGuAYcX3O2TPwSyHbgtOeN4cpAnRs48RfpV20mHPjpVCqs15W?=
 =?us-ascii?Q?5Ze4iRKFUv6D4h5hfpkp5r7b+2u8SyYzSoqQXkfpGofQf4MdumoveZe9MKnw?=
 =?us-ascii?Q?dhyyh+YjiF6h8dFE2FM6VOIhFDz5BsKqf8Kl9bRO/aP71i+nOivXW7axCTQi?=
 =?us-ascii?Q?vYnlLuM+uoiKLciOIEn6nGCatak+ORZ5ixTC/MY9zIvCCcIr4Bel?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2008b8-365c-423d-119b-08de698650ff
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2026 15:57:53.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9sBQdxr7Yg66W0zylfzHWMRcjli0AhUhpMtBbnFeyXE6QDWEtzjonc87RorUXYCNhyr1fl80gFZvsVuPmqAuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3720
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8884-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 007D1125E4C
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 05:30:10PM +0100, Niklas Cassel wrote:
> On Tue, Feb 10, 2026 at 11:07:16PM +0900, Koichiro Den wrote:
> > On Tue, Feb 10, 2026 at 01:24:29PM +0100, Niklas Cassel wrote:
> > > On Mon, Feb 09, 2026 at 09:53:08PM +0900, Koichiro Den wrote:
> > > > Tested on
> > > > =========
> > > > 
> > > > I tested the embedded (DMA) doorbell fallback path (via pci-epf-test) on
> > > > R-Car Spider boards:
> > > > 
> > > >   $ ./pci_endpoint_test -t DOORBELL_TEST
> > > >   TAP version 13
> > > >   1..1
> > > >   # Starting 1 tests from 1 test cases.
> > > >   #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> > > >   #            OK  pcie_ep_doorbell.DOORBELL_TEST
> > > >   ok 1 pcie_ep_doorbell.DOORBELL_TEST
> > > >   # PASSED: 1 / 1 tests passed.
> > > >   # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
> > > > 
> > > > with the following message observed on the EP side:
> > > > 
> > > >   [   80.464653] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback
> > > > 
> > > > (Note: for the test to pass on R-Car Spider, one of the following was required:
> > > >  - echo 1048576 > functions/pci_epf_test/func1/pci_epf_test.0/bar2_size
> > > >  - apply https://lore.kernel.org/all/20251023072217.901888-1-den@valinux.co.jp/)
> > > 
> > > I applied this series on top of branch pci/controller/dwc
> > > on Rock 5B (pcie-dw-rockchip.c).
> > > 
> > > On EP side:
> > > [   39.218533] pci_epf_test pci_epf_test.0: Can't find MSI domain for EPC
> > > [   39.219125] pci_epf_test pci_epf_test.0: Using embedded (DMA) doorbell fallback
> > > 
> > > On RC side:
> > > #  RUN           pcie_ep_doorbell.DOORBELL_TEST ...
> > > [   40.297892] pci-endpoint-test 0000:01:00.0: Failed to trigger doorbell in endpoint
> > > # pci_endpoint_test.c:279:DOORBELL_TEST:Expected 0 (0) == ret (-22)
> > > # pci_endpoint_test.c:279:DOORBELL_TEST:Test failed for Doorbell
> > > 
> > > # DOORBELL_TEST: Test failed
> > > #          FAIL  pcie_ep_doorbell.DOORBELL_TEST
> > > not ok 23 pcie_ep_doorbell.DOORBELL_TEST
> > > 
> > > Any suggestions?
> > > 
> > > (All BARs in pcie-dw-rockchip.c is marked as BAR_RESIZABLE.)
> > 
> > Thank you for testing.
> > 
> > If the failure was observed in a scenario other than a plain
> > `./pci_endpoint_test -t DOORBELL_TEST`, could you please try again with [1]
> > applied as well?
> > 
> > [1] https://lore.kernel.org/linux-pci/20260202145407.503348-1-den@valinux.co.jp/
> 
> I applied that series, but I got the same problem.
> 
> I added debug, and the EP side does use the correct address for the eDMA:
> [   26.279457] msg_addr: 0xa403800a0
> [   26.279898] phys_addr: 0xa40300000 offset: 0x800a0
> 
> 
> If I write to the msg_addr directly on the EP using devmem, I do see the print
> that I added in the IRQ handler:
> # devmem 0xa403800a0 32 0
> [  155.861989] dw_edma_interrupt_emulated:696
> # devmem 0xa403800a0 32 0
> [  158.809160] dw_edma_interrupt_emulated:696
> [  158.809543] pci_epf_test_doorbell_primary:729
> # [  158.809986] pci_epf_test_doorbell_handler:703
> # devmem 0xa403800a0 32 0
> [  161.241326] dw_edma_interrupt_emulated:696
> # devmem 0xa403800a0 32 0
> [  163.466054] dw_edma_interrupt_emulated:696
> # devmem 0xa403800a0 32 0
> [  167.378662] dw_edma_interrupt_emulated:696
> [  167.379045] pci_epf_test_doorbell_primary:729
> # [  167.379512] pci_epf_test_doorbell_handler:703
> # devmem 0xa403800a0 32 0
> [  168.880179] dw_edma_interrupt_emulated:696
> # devmem 0xa403800a0 32 0
> [  170.492176] dw_edma_interrupt_emulated:696
> # devmem 0xa403800a0 32 0
> [  171.729154] dw_edma_interrupt_emulated:696
> # devmem 0xa403800a0 32 0
> [  173.481271] dw_edma_interrupt_emulated:696
> # devmem 0xa403800a0 32 0
> [  174.985787] dw_edma_interrupt_emulated:696
> # devmem 0xa403800a0 32 0
> [  176.517131] dw_edma_interrupt_emulated:696
> [  176.517511] pci_epf_test_doorbell_primary:729
> # [  176.517963] pci_epf_test_doorbell_handler:703
> 
> But not on every write....
> 
> I'm not sure, but could this perhaps be because we are missing this patch:
> https://lore.kernel.org/dmaengine/20260105075904.1254012-1-den@valinux.co.jp/

Thank you for the detailed debugging.

I don't have a Rock 5B to reproduce locally, but your log indicates that
the emulated interrupt is not always delivered on the same eDMA IRQ line.
On RK3588 (rk3588-extra.dtsi) there are multiple eDMA IRQs (dma0-4), while
pci-epf-test requests only epf->db_msg[0].virq (IRQ 53 in your
/proc/interrupts). For R-Car S4 Spider, chip->nr_irqs == 1 and I wasn't
able to verify whether my earlier concern here:
https://lore.kernel.org/linux-pci/p4ommmpcjegvb4lafzecf67tzmdodtuqexeoifcn5eh7xqyp2y@ss76d3ubbsw7/

  > The proposed dmaengine_{register,unregister}_selfirq() APIs are
  > device-wide (i.e. not per channel), so I'm not sure which "channel" you
  > refer to here.  Also, when chip->nr_irqs > 1 on EP, dw-edma distributes
  > channels across multiple IRQ vectors, and it's unclear (at least to me)
  > which IRQ vector the emulated interrupt ("fake irq") is expected to be
  > delivered on.

actually holds true in practice. Your report makes it clear that the
emulated interrupt can indeed be delivered on different IRQ vectors.

One hypothesis is that: we currently program msg.data = 0 for the
"embedded" doorbell, and we write to DMA_READ_INT_STATUS_OFF. The register
field (RD_DONE_INT_STATUS) is defined per-channel, and the register
supports interrupt emulation by writes, so it might be that writing BIT(n)
selects the channel/irq line, while writing 0 does not consistently map to
a specific one.

Could you try a quick experiment on the Rock 5B EP side?

  devmem 0xa403800a0 32 1
  devmem 0xa403800a0 32 2
  devmem 0xa403800a0 32 4
  devmem 0xa403800a0 32 8

and see if the interrupt consistently lands on a specific one of IRQ53-56
for each value?

If that is the case, we can make msg.data non-zero value instead of always 0.

If that is not the case, then we may need to consider two less ideal
options:
  - switch back to the ~v3 approach, where we run the registered hook
    exactly at the time when the emulated interrupt is deasserted. (ref.
    https://lore.kernel.org/linux-pci/20260204145440.950609-6-den@valinux.co.jp/)
  - or, require users to request_irq() for all irq vectors associated with
    all channels. However, this would not be very attractive from a design
    perspective.

> 
> # dmesg | grep eDMA
> [    1.243339] rockchip-dw-pcie a40000000.pcie-ep: eDMA: unroll T, 2 wr, 2 rd
> 
> # cat /proc/interrupts | grep edma
>  53:          8          0          0          0          0          0          0          0    GICv3 303 Level     dw-edma-core:a40000000.pcie-ep, pci-ep-test-doorbell
>  54:          7          0          0          0          0          0          0          0    GICv3 304 Level     dw-edma-core:a40000000.pcie-ep
>  55:         15          0          0          0          0          0          0          0    GICv3 301 Level     dw-edma-core:a40000000.pcie-ep
>  56:          7          0          0          0          0          0          0          0    GICv3 302 Level     dw-edma-core:a40000000.pcie-ep
> 
> 
> 
> Anyway, I was still curious why this did never worked when writing from the
> host side, even when running the test case many, many times.
> AFAICT, the inbound translation looks correct.
> 
> RK3588 (pcie-dw-rockchip.c) exposes the DMA registers in BAR4 by default.
> If I hack pci-epf-test on top of your patch to unconditionally return BAR4 with
> offset 0xa0, it works. So my best guess is that the fixed inbound translation
> in BAR4 (to the eDMA registers) somehow messes with the inbound translation if
> another BAR tries to use an inbound translation to the eDMA registers as well.

Thanks a lot for letting me know that. I see two possible ways forward:

  (a) extend PCI_EPC_AUX_DMA_CTRL_MMIO to optionally describe that the DMA
      MMIO window is already mapped to a fixed BAR and should be reused, so
      EPFs avoid creating a second mapping to the same target. I guess it
      could be treated as a quirk for "rockchip,rk3588-pcie-ep".

  (b) alternatively, clear the default BAR4 mapping on RK3588 at least
      temporarily when using the pci-epf-msi doorbell fallback.

Koichiro

> 
> 
> Kind regards,
> Niklas
> 

