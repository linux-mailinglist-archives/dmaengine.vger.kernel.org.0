Return-Path: <dmaengine+bounces-9141-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LAFDiQ6oWlrrQQAu9opvQ
	(envelope-from <dmaengine+bounces-9141-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 07:31:00 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 670091B342A
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 07:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A9F930200E6
	for <lists+dmaengine@lfdr.de>; Fri, 27 Feb 2026 06:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF7533A9F0;
	Fri, 27 Feb 2026 06:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BG5n1b3C"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020120.outbound.protection.outlook.com [52.101.228.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498A02798E5;
	Fri, 27 Feb 2026 06:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772173855; cv=fail; b=PB4xO7mTW2BOL8WyhWf4DJxEIgVQ582kc21bcz7SnmtQ8fkmDhwooK/7+oyWjwWj3xqpjcGk9oRtDIXDqgm1PD/agdVlOvBj+lSad+M74v0umY7SZfnD1ymdqbjROTcsRlROztdZ6QrZqN9Jmhtf1n7xqLfwZevEhaLRhD/AteE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772173855; c=relaxed/simple;
	bh=DsnmH54BtD100UOVpWbG5UkGHj5gwYTGgZy8iJEuUKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mJfb7UC+7n5SzTCKB6sS3tS6ehBR9ISW5E1uz7RAZmMzPiomA7z/F6oXywYw7kpSctbFcgJFBqZ28qnk8csV1WIp7NAxMOBWi1hYgCsOyGtMu7x8124j+vvJMjNjcBueITT2BI/vgA9TGyw1mh4ZzPLiMM09FGb3ka+CtUjTM5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BG5n1b3C; arc=fail smtp.client-ip=52.101.228.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OFZyOydIk+lW6Pnm0lZ37CizPK6fyJyMJDc/9aeTSVj6T5UOpmLB+OmAb3oOKaoCGWRXI6hclCNMStO7X/0QB2p29BnR+BEEN4jqqdfaX0wUbN76gd5gqGCVV1wAwmPZonioxV/ezsuzyV7C2dkM1FdN3ma4p2nue1Ma2U2cG3CF6E5rQNH2VGN4NRF1yY5JPEA7Y56aXHuoLjaTMVceTkYXW3ym/rKacuDxvSv7Dvs/0YQOY0nWHo1llnmRaR1CwP20W2ySQsL7YGLJ6xmsSjbWmJ3IDqwMbWvpya03h3ibs+pTC8uCGCJLFPjGn1okpFo4/bcvvgCYAq7FJSkX1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coeY/EEjYn2cyjve5+ScveIXdBAsUMxp5BZ/tKqfZK4=;
 b=IuZUmZS8QlbUytDsuyQLUz5wWn/6oBFkTtBiea9MRz2MYVa+yZBynrnWm67oSxF22wqDDL5H+G7n3D0/gobz36e6kWPzl2Lrn/9GW3On6lBgsgYfUcOKfZPZZgFkAeIY4uWvrFTkpJxemy2s5qTitnYI7acQtEM6GAin1sikQSPBTSuom8qvftuKXVGAlqyVyFCmeeSkw14ASiqXQyEQ78CEx29F6+HYAzYmya4yGg6zCKOt89ct6V357UIBsHSjp5qRHJIJ5FHqCY+wGMwjBy2ys1E+qE4CzEjwoj0cmUZujOtrvm6pTW7kIWjHjoZ0ZmdqNI+C8dF4ebfA/D9tmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coeY/EEjYn2cyjve5+ScveIXdBAsUMxp5BZ/tKqfZK4=;
 b=BG5n1b3CjK9in9IVrI6W0XcpxNbjqjKmt8p0Ve3RakjDZorO7knjimtjeHXgluqls+PucKgV+Uf9EM44zFWdeJWVQS8DaUoLHd69RBWI+GlVQR07e86/80X1Jdr4WTPtYHqKs2EdqtPIv/gfgeBycbzHqBisbrTURNZAgVJFriE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6657.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:31f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Fri, 27 Feb
 2026 06:30:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9654.013; Fri, 27 Feb 2026
 06:30:50 +0000
Date: Fri, 27 Feb 2026 15:30:50 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 04/11] dmaengine: dw-edma: Remove ll_max = -1 in
 dw_edma_channel_setup()
Message-ID: <i5l46rrrsjzozimlcpids54cgf4yvrlscgjodduga6smklf7iy@norudq3os5le>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
 <20260109-edma_ll-v2-4-5c0b27b2c664@nxp.com>
 <6d6c222faypvbo6fvs7tad2gtzxqqzlsjkrbefwmgxodt5thbc@lylpaqxozrg7>
 <aZ8YpKPqSjzDtomb@lizhi-Precision-Tower-5810>
 <esdpmy46hffpg577hd67rxmpkfm3agrzrginegi2rczbwvdnlb@urqmwhh3kuff>
 <aaBk-I5jrut5wpT7@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaBk-I5jrut5wpT7@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TY4P301CA0004.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: f665124e-ef65-4abc-1a25-08de75c9c03e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	W7EKyaRZvsy9yfmqSnZ2WXN53VsYBVyynv1Xk4MZfqHiRlAGH2CBaDNRr2ytTWyOEyvn5Vh71yynbWkL5u0mK4NwV9oZwvJ1+4KyUuLd1AS8OjWuFXXJW6Rndf40PzK8bdK0aW1lIDrfaqTXTE0jyIKwLUAhrDFOYPcSTtJ0V9e77QY2VsEuKAej25vJFFnC2LVUOrZQjNNg+LNwOBHMhNk6lsuVMPw/xDqoe7+MJsYdLDgt1XBwUpsiLEqaH73OQorNheivqi8y8Bh3JE0Ic4GlF5ZnbyNKRJFf+w4CO7UEBJGVVc2KoUl+fzKlSwrK+ZNvDF2gQNzZHIytEQZ7b7purs354jRAZYgwPeoM59N7oJzpW253jh+444KMMEM6s7OLy5V15eJbuskFxduESCYwWSQA2T4DfjnknIQ5zI5JEDYboUedOnqata3AIYz2uAOWBdlb0nl0JpqfUI0AOp0w4Ijid7uZzKxgDpE8K7dkMI0RqC5wdsDs3G9/kKb5eewSZpfZHXSPp2Ew0z5QyQSZ2cXRLjDSwWbkfXFMAoZ6pqafRs4ZfJOsdUV9LMCwwX4Ryw9KVpsRztmcfo9pQjZF7M8i2LXSvcSSyEJwblY7kFDB4FGO/saCCye00RL4cPGOECXUrkDZTKWqos3Iic5xVMRKvubX2czMzLOnJ8yFZis4vD7RdpJofRturokB41bri4TUHYOwW5t28AwJKw9oAYhDgLDrD3yXlzDHWFM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?apTl/8QHKlRXfW4ihArcK2dXFicoY4V3g/rBbpEpoXGKfDsgUHFX+uWJsslk?=
 =?us-ascii?Q?gtf5aOk4zyOn/6SzMUFBi9oYgikmcdK1ta40tbuPug1F2J8ikFu0/dCQ39Z6?=
 =?us-ascii?Q?35ke6qwpgCSkfBbN+ldVUrwr+OSsBsZxYr2nov309bTVrXOblCSyeRo9pSk+?=
 =?us-ascii?Q?zJBlCnVfUpfL/5TKUaL3VZex2Q07SW+MHTC979w2OjWPt+hElFY10+1PNzna?=
 =?us-ascii?Q?E8ImA61ASL2aB5+66N5ANLGIqMTthKrjTNkD6VJzRQNuGkY2O4I17Xh+DSFq?=
 =?us-ascii?Q?vrSejEOsRqHsPPAupk4MSOvbMS2nbRH9MAOKNk3MMAbrjZ4RKavnpMT2R1hq?=
 =?us-ascii?Q?cOrBpJRX7+InwNUBTCtiKhWh3RGPVaN4bvYw+eRXydRVfVQ5q8dJlTJLtUZe?=
 =?us-ascii?Q?rvyV09o9GCtAJAQe3hxi4cm869sMjYz/QcesS+42IT8WcxWhn4OVcRlkFcW9?=
 =?us-ascii?Q?xFDzyetJnPCuCrPPmOO555+KgtOOLcOTU2ho+zJlA/kPyX8dysVB70KkpgCH?=
 =?us-ascii?Q?dJwSzZTBLgXKRFhF9GRsfCL/SA5b4G9hPJQhtUTq7NltQt80A9nJkN6OeQ4x?=
 =?us-ascii?Q?dfZUi07yFWbBDrg+mY0Ktrol+c/t1DZqss+vkBl4AcOsQPIyRJzrUpHpoDeF?=
 =?us-ascii?Q?I4H/3JL2Ppe/AQ/+aS20G8/JmxsGD/7ngaWyp/aoz1glOJiU4mDyKQyjp6qZ?=
 =?us-ascii?Q?OidYP2y1bJ6jm9l49YzY/4gbIimwYbwdJgeRMW+6UXFVGtarrWBHhdiwHOwD?=
 =?us-ascii?Q?cvks+pOLQ5ufSXUHqmfz04zevUHKohUHm/5Pr3EX7TgrreKPnbyJtUusCOtK?=
 =?us-ascii?Q?bcGNtSlZhnNm7yo00PzDYekKEpHdbi4z3Visn+l7rJXkaaYE11qh9VePR75h?=
 =?us-ascii?Q?AYhYFt6q/JSNuKfJVbHi8X7TJeCd3rVqJUiOyI+2lutK2a0H+/w1T+VwHxn+?=
 =?us-ascii?Q?7jTpZu+t+B2oPKBB+oMpgYs/4W/VbQSoDs8r3ILDOd7XfdjeSgDS1Iw3k9Z2?=
 =?us-ascii?Q?d7Tz+PJ3xUEIjPGTf+XIaYkzE9lNtq9LHxA2JBdBhSQLb6Gv4nRelfBy1g1k?=
 =?us-ascii?Q?vwN1PbflVHMEKHxOThVGVhCVLkcAagXFLea8iinrVd1VCf2b4FqaFR4Sclk5?=
 =?us-ascii?Q?RyfYuG8Ke2LAZEMnyaqCnncOyIqtGfjMh2qdaroXwwPvIhY0HEZX0PBfm0KJ?=
 =?us-ascii?Q?BZAFhSuEtRYCsg+dACzObsYymJ0PddLuWWhSukCuXBFOst3jij9jSElUiIZx?=
 =?us-ascii?Q?s8kss6NCxv6fknwh9K53rJPyILx7g5OBYLL/KJ/sBv3XcVUN5OVIYvaOqHIa?=
 =?us-ascii?Q?h4laDDk1fX6IvWIMyxCy7pDPakbzEPXEJyqE/Mru2W0J0w6KMmREAqOPCx2c?=
 =?us-ascii?Q?yL5vgfnrtyMDiH+RwCnOCMhsiXfSxsvsCJ7+v0YW0cpdiEmYe8Tdo9CbuWrS?=
 =?us-ascii?Q?mee1tdJnWRFS9xRsDXOkDfXah4YEr8Y+xw90jz1IgA7P8mFgjZ/y90zhQbEV?=
 =?us-ascii?Q?pol1/4WT+P57eF0CQghTHhISdXcKg7zvO5GP2Qf9gmxo8ES9cXqY2UUPTr83?=
 =?us-ascii?Q?No/JTZna1ZY4UvnfC7LJ/BLkIehBrcfMsdbEk11KfhXXXbNwj6IgCQ+gV29i?=
 =?us-ascii?Q?P2D2Vl1aqyIu6aiIpof6VPSt+iCDtVEcI4EkzCaq1s3Q3k7jFs4NU4ScBCak?=
 =?us-ascii?Q?oJYPLSXPy2g4Gw+HPu77tzx8c6LiwAtKl15Buu6jc4DzBiLv6g/HSSWRAi9u?=
 =?us-ascii?Q?EmoHzSM1jIw37/VoPLlRu0Zpob+85/sQCndZl2mzxSPALS4KGQ39?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f665124e-ef65-4abc-1a25-08de75c9c03e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 06:30:50.7958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MPbx0uTXn4e/RdZdYYr7D4cuaayvhGgxbFKE85Yog/3UIKdC7Y+OUHswZjgP6DjVYrJr07/F9E/H6sc4rdnIFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6657
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9141-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:dkim,nxp.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 670091B342A
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 10:21:28AM -0500, Frank Li wrote:
> On Thu, Feb 26, 2026 at 11:16:26AM +0900, Koichiro Den wrote:
> > On Wed, Feb 25, 2026 at 10:43:32AM -0500, Frank Li wrote:
> > > On Wed, Feb 25, 2026 at 05:30:33PM +0900, Koichiro Den wrote:
> > > > On Fri, Jan 09, 2026 at 10:28:24AM -0500, Frank Li wrote:
> > > > > dw_edma_channel_setup() calculates ll_max based on the size of the
> > > > > ll_region, but the value is later overwritten with -1, preventing the
> > > > > code from ever reaching the calculated ll_max.
> > > > >
> > > > > Typically ll_max is around 170 for a 4 KB page and four DMA R/W channels.
> > > > > It is uncommon for a single DMA request to reach this limit, so the issue
> > > > > has not been observed in practice. However, if it occurs, the driver may
> > > > > overwrite adjacent memory before reporting an error.
> > > > >
> > > > > Remove the incorrect assignment so the calculated ll_max is honored
> > > > >
> > > > > Fixes: 31fb8c1ff962d ("dmaengine: dw-edma: Improve the linked list and data blocks definition")
> > > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > > ---
> > > > >  drivers/dma/dw-edma/dw-edma-core.c | 1 -
> > > > >  1 file changed, 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > index c6b014949afe82f10362711fc8a956fe60a72835..b154bdd7f2897d9a28df698a425afc1b1c93698b 100644
> > > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > > @@ -770,7 +770,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
> > > > >  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
> > > > >  		else
> > > > >  			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
> > > > > -		chan->ll_max -= 1;
> > > >
> > > > Just curious: wasn't this to reserve one slot for the final link element?
> > >
> > > when calculate avaible entry, always use chan-ll_max -1.  ll_max indicate
> > > memory size, final link element actually occupted a space.
> >
> > After the entire series is applied (esp. [PATCH v2 10/11] + [PATCH v2 11/11]),
> > yes, that makes sense to me. My concern was that before the semantics of
> > "ll_max" changes, this "-1" was required. In other words, this seemed to me not
> > a fix but a preparatory patch. Please correct me if I'm misunderstainding.
> 
> Thanks, I found I make mistake, wrong think it as "chan->ll_max = -1".
> I will squash this change to patch 10.

Thanks for the confirmation. I agree with the idea of squashing.

Best regards,
Koichiro

> 
> Frank
> 
> >
> > Thanks,
> > Koichiro
> >
> > >
> > > Frank
> > > >
> > > > Best regards,
> > > > Koichiro
> > > >
> > > > >
> > > > >  		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
> > > > >  			 str_write_read(chan->dir == EDMA_DIR_WRITE),
> > > > >
> > > > > --
> > > > > 2.34.1
> > > > >

