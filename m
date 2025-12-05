Return-Path: <dmaengine+bounces-7510-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3049CCA826A
	for <lists+dmaengine@lfdr.de>; Fri, 05 Dec 2025 16:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8223531E0EEE
	for <lists+dmaengine@lfdr.de>; Fri,  5 Dec 2025 15:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E985B346FC3;
	Fri,  5 Dec 2025 15:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PtYyUH0P"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013025.outbound.protection.outlook.com [52.101.72.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E755F32FA3C;
	Fri,  5 Dec 2025 15:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764947212; cv=fail; b=fCxVzRXNIoNi+06bfvDFkInM3iGL3PxGSq2hKqpxRkUSnALdEANNKBHSIyciXBeLNqRHcEiBQh+K6x0Hz8FTl8PaBhK61IeGXlT3udRfYw0r0+k/9Z+iSg1RCWHxS8++JyYgoI6f+xfKXnn0Zv9PEGeXZ34ikVihLefgCWvFhf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764947212; c=relaxed/simple;
	bh=8hkUbqbxf4K3wOwy5MrU280HLTJ4Yakut6/h9SPP8bY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dmCTy6RKE8j3km4OZpKYfv3NwN204J7wPnnGT2GoVJls3m5lmi2VjvjG1zLCuHT6c6XtHDtipssRo4omiOiAmAquuKa5DuPePwEkSCffSSL1/4VSA1C7JotGZseWanF+6qoN27uzRh1YrNgLZ61foPujN4LNur8dP3g3+puhpd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PtYyUH0P; arc=fail smtp.client-ip=52.101.72.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pe/PAL6lOjd2njOpwHV9ovv0lXssi0UDqvnlmywx34sklb1huuDFETR1JPHEboKVQhMcKmkqeQz7Amp638qhkgwQKZTyl7BQCQ3Oqk16Yo6B1ChTJV/z23kYuPWhoNegoWFE/bIMPda/W8+gIjdQz+GL6lP38nYS5l+w4tFBC62nAzvO3o+nWCUv7U6U/QqmPPORxhKpr67k32FtSFlkXWqZBHBTuGouKozOeqgS3UAi2a8iDiSd0XjGYUzxybBNyezMKP7t6R6GsMsTWn0GzwWeB4lsw4VDl/CrKGl9Fhb/NT33we7+d+yBOMLVG1S5Bho9yR1mVd3NyKnwjyPULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nnLEkjmrkhzO7qJMBjplS41cH7FFkzwXVYXQXvgaONI=;
 b=yNPYEznZiOj0CoLSCLmT6TC9CZGBqmnwit1J69I4K7HO0vfYdvnathNTzpFpug6zFAuQyINyEIGjkjWbPeRXDbXFuNQBcEiA9uDJdZkkoEoOKkG8/7MZFdZbJGRk0ZvGCyj7sSG+UNLTbRN2VvlfUm7h3GpxKdiRSpR9+P2h9+G0Hv8UIqWD1+p3WQor6lmJ/UQ7CwVmnuIc1x1N059oo8m9YxE8X60sS/gGaDCTklfLulKx+HupfSuiwY4RBJcHpli4GRukrOR5QJ8zcyUgQFXI8z0MAprL25D6K+M+sZZ0gnp6hgCpaRJtbQQMRMrJIUL7/ByG+ldcrrBBxXl6CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nnLEkjmrkhzO7qJMBjplS41cH7FFkzwXVYXQXvgaONI=;
 b=PtYyUH0PKNRY9G1kk/J16GkNy2bKqAOwEkD7dUOEg/c10XGpnd0tpamqcVCZxUiX9uw/c9xHMacqskecBiPHOet38XUZPe6EiiIN61jNwWs2bUzlTSdbvb6qjXKw29Q9U7elK/Af/LeWONH7w7EOYUyLkQeF5EZ7oEc7juI/oPIg6Y82fnYXo7t3iUKnvISHWCQLF9vrOTd18RD7qCOcALJEgtAGgGCWUCvheakDNPToXkwXeiGUqepHSJ6QBv/UMOGK5/02PPAsFztUCeLwHwr/28lJ2A2Rko/o6O90OILzM4CQQ/iqb0SfmKxaPzdvDwOWD56Y1ZyyFFsDAVMajQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com (2603:10a6:10:2e2::22)
 by DB8PR04MB7068.eurprd04.prod.outlook.com (2603:10a6:10:fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.11; Fri, 5 Dec
 2025 15:06:41 +0000
Received: from DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196]) by DU2PR04MB8951.eurprd04.prod.outlook.com
 ([fe80::753c:468d:266:196%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 15:06:41 +0000
Date: Fri, 5 Dec 2025 10:06:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	mani@kernel.org, kwilczynski@kernel.org, kishon@kernel.org,
	bhelgaas@google.com, corbet@lwn.net, vkoul@kernel.org,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com, logang@deltatee.com,
	jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de,
	pstanner@redhat.com, elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 20/27] NTB: ntb_transport: Introduce remote eDMA
 backed transport mode
Message-ID: <aTL09kE6y9A0gLSn@lizhi-Precision-Tower-5810>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-21-den@valinux.co.jp>
 <aS4Lcb+BjjCDeJRz@lizhi-Precision-Tower-5810>
 <jiigiyxb2hllpeh3znbfy4octtubvkkrbxv7qfzzivimvz7ky2@i7b7a66peapf>
 <aS8I5e2UguQ2/+uU@lizhi-Precision-Tower-5810>
 <27mhsc7pksxyv62ro2m4u4xblednmlgsvzm6e2gx4iqt2plrl2@ewtuiycdq3vj>
 <aTBh86H5m6PpIxMk@lizhi-Precision-Tower-5810>
 <47ns4b4oskh5yukig7sr4okhw6gvqf4q5yin2ibrpue5zrcplp@ybozsroia2fk>
 <aTHsGerE5phzLrgk@lizhi-Precision-Tower-5810>
 <nbjr7ovjgvrvcr7sntrgcjyui5tukp6utd5bvqc3hsdopsl3vi@or4vjl3owblf>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nbjr7ovjgvrvcr7sntrgcjyui5tukp6utd5bvqc3hsdopsl3vi@or4vjl3owblf>
X-ClientProxiedBy: SJ0PR03CA0346.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::21) To DU2PR04MB8951.eurprd04.prod.outlook.com
 (2603:10a6:10:2e2::22)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8951:EE_|DB8PR04MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: c943f7cf-c15c-4abd-5199-08de340fe540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aqA9DzjFZRSRKDAN7gSWeTUGe6EZN4IV1Tj6s7K0gPfS0H9cpu4ez7rtgqF3?=
 =?us-ascii?Q?ySWewnDoUpX39uhSng17EbHXxuoNbS4xKlJ0LqcN4FbXVXQXluPv7pU3LeGq?=
 =?us-ascii?Q?k6Ddo+DhpCVXQfXHSEsfZ35n5MgOblurWKNEf3yQvvZQWf4k05lZ/dVZl7d2?=
 =?us-ascii?Q?7trydMmNkIMEhlWAJWqrrBgn993Zs39SA+9KXQBzWDHu4EndeKBfsfADj3hW?=
 =?us-ascii?Q?WsXp5O7n5IdAk+Shil6c4WN6EV37Anm/pL8C3d8fk4dIC9ygRfFXQNfARkB1?=
 =?us-ascii?Q?JrfjfPjAGeo2sCxYyStJZYHNhr9al/9/mgTFTNxZ2l4FGQZkeiIs/Vm8JJ2O?=
 =?us-ascii?Q?a4bLXq2frYbKOU8WQUmd7QdAbS1GdiGFaWAOrmxcwGsCZVE7uZCPWQPdpwvm?=
 =?us-ascii?Q?U1fr47BafulpbFxkk+AeRld6xS+JveWrvmb5ACp957xDsib6PIwAUi79NrHQ?=
 =?us-ascii?Q?uz41iJtSZ+Lbsdyqsy2fjxsop8byfYFuQahWmAYjHh8PyoER4BBw9f+slVMH?=
 =?us-ascii?Q?KaGfoWTcwf4+n1u6FTgTR3mfyc7rmXBQU44e2ZqkrSvBnmNp9I4gJ7v6Jp0c?=
 =?us-ascii?Q?vmc4dR/aOOlY46em/LOh7LAa+n2ZEhRsZeM7FjlRg91wSpstMfHB51fWC5yx?=
 =?us-ascii?Q?Ivz0GIcxFmvJXuj7NQgg/z/viPZqjik3so68xEMDmn1JI16dNQaW0tvXfpGU?=
 =?us-ascii?Q?EoYdo3giXEHAPxvgogXMWQO67ebHL7vMjZwWc6cAgYSum9ahgVMJsfhwLTHw?=
 =?us-ascii?Q?w7fFyHbTGqDInq4MGiRPVNFE7C2bROrw4tUGt9I5qcYG55feoKhx9Ah9eSz3?=
 =?us-ascii?Q?+eMF9MOGnWXyczd423/+cCNqkHom/aTCpquI1EPf4rQz3jOd92CIJfm59zHG?=
 =?us-ascii?Q?YeBI/QyvkzQLuV7TVGvN8xmpGWD0P8tsqBrMqjcE8LRKeF6gmtAYctMj7n08?=
 =?us-ascii?Q?hoky+yzuiBQfY5hmND3Ve7t7r6oJzl5NVKMIAZeZZAB2w94LHoJeY01h5mPA?=
 =?us-ascii?Q?DB3TGSA0wti5klFAMqbwuwxjK7C1ge8HU7QqbV2unF+fhSfFb5heplqpfMax?=
 =?us-ascii?Q?R0z5HaBTCmpP9Foewt11mCpdT7vAN3LzsL2Fmj8UUoCkYcn8YQNgh15vyZmP?=
 =?us-ascii?Q?GhF/9zluH2gf3pyVQ56loFvWKou6id5HkWy3KnSJsgMnFlSQcaE5OSblHF4O?=
 =?us-ascii?Q?T7YINmIRfazgTxd89XheGaKlnpaabAcRhYEnVb1PppOetoYaBkZjJZj+uqhl?=
 =?us-ascii?Q?zB0lZLf2l83MhX6m4+xLPrDex7xArFMvDbgiTi0xzWE1e/OJV69rO1Kxyilk?=
 =?us-ascii?Q?zpSmoUrSqq/rQQFnrDgLfnBgy+JcDTcsVme1f0jAfVv6STNfObYTykXO+rd7?=
 =?us-ascii?Q?RbSjSWm3Ko+VoETSnpQLQJkB6+xMmm0Enff2UZ1xATk2DD4n7frxx3unMax3?=
 =?us-ascii?Q?qmKZed4zNl+aULOkJYukZAqOsKJDZd5QvJR73V1zf+d8pdFkN8E1KQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8951.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PW/0VXifQKXf36hdBBcuYrLKufgmcfIjk2uQZMEAvh33LOaG9CcNCnBMCIrw?=
 =?us-ascii?Q?khCiL6zuVhFqeR1g6BOsui3voJ4nJ38UZi1D3wAUqf4TmHXWfSIsF6EZtJaA?=
 =?us-ascii?Q?puypvWZdlMsQwmjQlPjnj1c+urjgDl19+MuxI7HQdrYnOiRFvTcsLPvrPCh7?=
 =?us-ascii?Q?DHjLsaYT50gBnvieiogvoCvDdu2QZvxE8HympgTzHk0guww0zWp0ZEwaR7+B?=
 =?us-ascii?Q?F8H0vwkZm/EbKFZFeVQz4ZHfvTy8ahxm/DGtB4HpqF2bnJOOb+G6rE/aFLRj?=
 =?us-ascii?Q?8IrfWSiYBmORDYKTn6hzhKSyYqaMV1xmXYzsSJ3Hi2EJsFhlC/hf/pAuirFe?=
 =?us-ascii?Q?FT9kiKUF56fTgFLAKCoq2EWbfrqEADErKueZ+7GG+A7/p/XUIq3RRvXAUhPY?=
 =?us-ascii?Q?15v386ijwBpoP0P2oZtC6wlh3ACqm/UjwgaetCpv2oqXknD/YazcT5zoEDrP?=
 =?us-ascii?Q?JlwKLip0SDtlfexvYPvWRMFDc3CSTJQErZxeFdaB5vgC/MfUPHwJQZHJJdhO?=
 =?us-ascii?Q?CLsSslols+i2JXGjWOdqOZLKKf8wg1aayxtMxMflJPzaoYZ2VlVzM6RnqkGD?=
 =?us-ascii?Q?jdsi1qNutW9HbGwuT9VgUlTps66D5dRpECM+RqJPoe7Zdu3MvOiBtecpBVFM?=
 =?us-ascii?Q?7huAvqG+eCwo+vX4uyfqv9VRIUqrkNi5XoWI3VJ+rLgxjCBV0Dfh7SP1eTdo?=
 =?us-ascii?Q?ioARCX54BLx6FRYe+lCj6RiLF9TUot0u9jkQjkIYZF4JmYtvZUUob7LWuOjY?=
 =?us-ascii?Q?itZhnzXO54f9TFFRtnZxjteg+4I10WT7IIuE2/BSl3EGCVw/tMRwaKgZboQf?=
 =?us-ascii?Q?15gGugzxBIqvO/AMZzoNHGN47bvmHfP4pRmFVnDvm1ShhcJcbe0Uu7ewhRI5?=
 =?us-ascii?Q?22g17k/k9zGYtS2x5b2O87k199UgXSFUoR3/6pUWQjbiZvFZ4bav3B2vBkap?=
 =?us-ascii?Q?Vq2DwpWU3Cc9ZhVBEd83PPC3TQSQjKcxs99Dd7Elw8OXA8VCVHIlHqEW0krC?=
 =?us-ascii?Q?YoaDlGurg6wuCHU+UAwK0dQlAPEz3WANXmzU/znpV3YRCf9htcv6WufOBBJ7?=
 =?us-ascii?Q?xb+MEy4EfLRRMxwzOKOika+uzziQbvhuaslrE1NCA2ro2NUowYmmV6a/tsVC?=
 =?us-ascii?Q?nB4CA1QegcH0RuXVlJtA+UsxITSPlJRlNPpA7cGfDdtbNhUBwwIMqUhwF8Fq?=
 =?us-ascii?Q?RcG8rioSV8uT0w+sOZfSIJyV6su7tJW2rNXCBxuEx7mJfF0FFn7oMtN/pERu?=
 =?us-ascii?Q?lyGJl0jkdE0YGCPW7ltBu3fa8w68rTGw7pfo9GYqLQp0/dwVJk8IcvCigwEE?=
 =?us-ascii?Q?Yf79T6jdrIDYdzJkZBPLWATM+w5qN8akdbHKDiyK2t6x943HGTAjy5xKbjvh?=
 =?us-ascii?Q?OD3aNjT81l0TBV88nlP3czrvMdU2YSCUpucdrrsjeQj/4TYKWKh+walszJR2?=
 =?us-ascii?Q?+MFbj4zH/1XCHCZ9DV/1fGSKAGyEoWtAuv8dUKAi9o+RD+zkZh3ujAxAElBE?=
 =?us-ascii?Q?DZEhlIpXTDsKSTH7U0YZ6lEN+GesDHa3qVHkYuqtGtCjnB5D/CsgIEcZO8aV?=
 =?us-ascii?Q?yld3TAeFV0GtBv023WYJRSA0v44iz1/ijNEiEaN7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c943f7cf-c15c-4abd-5199-08de340fe540
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8951.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 15:06:41.1009
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmt2BHabjoynCrEFuqfyXsTazZrT2EBwTsUb/4xWmaBxyjJnXe6fYariLOFpEcV2lXfEByum7mEOaHQsaIf/RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7068

On Fri, Dec 05, 2025 at 12:04:24PM +0900, Koichiro Den wrote:
> On Thu, Dec 04, 2025 at 03:16:25PM -0500, Frank Li wrote:
> > On Fri, Dec 05, 2025 at 12:42:03AM +0900, Koichiro Den wrote:
> > > On Wed, Dec 03, 2025 at 11:14:43AM -0500, Frank Li wrote:
> > > > On Wed, Dec 03, 2025 at 05:53:03PM +0900, Koichiro Den wrote:
> > > > > On Tue, Dec 02, 2025 at 10:42:29AM -0500, Frank Li wrote:
> > > > > > On Tue, Dec 02, 2025 at 03:43:10PM +0900, Koichiro Den wrote:
> > > > > > > On Mon, Dec 01, 2025 at 04:41:05PM -0500, Frank Li wrote:
> > > > > > > > On Sun, Nov 30, 2025 at 01:03:58AM +0900, Koichiro Den wrote:
> > > > > > > > > Add a new transport backend that uses a remote DesignWare eDMA engine
> > > > > > > > > located on the NTB endpoint to move data between host and endpoint.
> > > > > > > > >
> > > > > > ...
> > > > > > > > > +#include "ntb_edma.h"
> > > > > > > > > +
> > > > > > > > > +/*
> > > > > > > > > + * The interrupt register offsets below are taken from the DesignWare
> > > > > > > > > + * eDMA "unrolled" register map (EDMA_MF_EDMA_UNROLL). The remote eDMA
> > > > > > > > > + * backend currently only supports this layout.
> > > > > > > > > + */
> > > > > > > > > +#define DMA_WRITE_INT_STATUS_OFF   0x4c
> > > > > > > > > +#define DMA_WRITE_INT_MASK_OFF     0x54
> > > > > > > > > +#define DMA_WRITE_INT_CLEAR_OFF    0x58
> > > > > > > > > +#define DMA_READ_INT_STATUS_OFF    0xa0
> > > > > > > > > +#define DMA_READ_INT_MASK_OFF      0xa8
> > > > > > > > > +#define DMA_READ_INT_CLEAR_OFF     0xac
> > > > > > > >
> > > > > > > > Not sure why need access EDMA register because EMDA driver already export
> > > > > > > > as dmaengine driver.
> > > > > > >
> > > > > > > These are intended for EP use. In my current design I intentionally don't
> > > > > > > use the standard dw-edma dmaengine driver on the EP side.
> > > > > >
> > > > > > why not?
> > > > >
> > > > > Conceptually I agree that using the standard dw-edma driver on both sides
> > > > > would be attractive for future extensibility and maintainability. However,
> > > > > there are a couple of concerns for me, some of which might be alleviated by
> > > > > your suggestion below, and some which are more generic safety concerns that
> > > > > I tried to outline in my replies to your other comments.
> > > > >
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > > +
> > > > > > > > > +#define NTB_EDMA_NOTIFY_MAX_QP		64
> > > > > > > > > +
> > > > > > ...
> > > > > > > > > +
> > > > > > > > > +	virq = irq_create_fwspec_mapping(&fwspec);
> > > > > > > > > +	of_node_put(parent);
> > > > > > > > > +	return (virq > 0) ? virq : -EINVAL;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static irqreturn_t ntb_edma_isr(int irq, void *data)
> > > > > > > > > +{
> > > > > > > >
> > > > > > > > Not sue why dw_edma_interrupt_write/read() does work for your case. Suppose
> > > > > > > > just register callback for dmeengine.
> > > > > > >
> > > > > > > If we ran dw_edma_probe() on both the EP and RC sides and let the dmaengine
> > > > > > > callbacks handle int_status/int_clear, I think we could hit races. One side
> > > > > > > might clear a status bit before the other side has a chance to see it and
> > > > > > > invoke its callback. Please correct me if I'm missing something here.
> > > > > >
> > > > > > You should use difference channel?
> > > > >
> > > > > Do you mean something like this:
> > > > > - on EP side, dw_edma_probe() only set up a dedicated channel for notification,
> > > > > - on RC side, do not set up that particular channel via dw_edma_channel_setup(),
> > > > >   but do other remaining channels for DMA transfers.
> > > >
> > > > Yes, it may be simple overall. Of course this will waste a channel.
> > >
> > > So, on the EP side I see two possible approaches:
> > >
> > > (a) Hide "dma" [1] as in [RFC PATCH v2 26/27] and call dw_edma_probe() with
> > >     hand-crafted settings (chip->ll_rd_cnt = 1, chip->ll_wr_cnt = 0).
> > > (b) Or, teach this special-purpose policy (i.e. configuring only a single
> > >     notification channel) to the SoC glue driver's dw_pcie_ep_init_registers(),
> > >     for example via Kconfig. I don't think DT is a good place to describe
> > >     such a policy.
> > >
> > > There is also another option, which do not necessarily run dw_edma_probe()
> > > by ourselves:
> > >
> > > (c) Leave the default initialization by the SoC glue as-is, and override the
> > >     per-channel role via some new dw-edma interface, with the guarantee
> > >     that all channels except the notification channel remain unused on its
> > >     side afterwards. In this model, the EP side builds the LL locations
> > >     for data transfers and the RC configures all channels, but it sets up
> > >     the notification channel in a special manner.
> > >
> > > [1] https://github.com/jonmason/ntb/blob/68113d260674/Documentation/devicetree/bindings/pci/snps%2Cdw-pcie-ep.yaml#L83
> > >
> > > >
> > > > >
> > > > > Also, is it generically safe to have dw_edma_probe() executed from both ends on
> > > > > the same eDMA instance, as long as the channels are carefully partitioned
> > > > > between them?
> > > >
> > > > Channel register MMIO space is sperated. Some channel register shared
> > > > into one 32bit register.
> > > >
> > > > But the critical one, interrupt status is w1c. So only write BIT(channel)
> > > > is safe.
> > > >
> > > > Need careful handle irq enable/disable.
> > >
> > > Yeah, I agree it is unavoidable in this model.
> > >
> > > >
> > > > Or you can defer all actual DMA transfer to EP side, you can append
> > > > MSI write at last item of link to notify RC side about DMA done. (actually
> > > > RIE should do the same thing)
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > To avoid that, in my current implementation, the RC side handles the
> > > > > > > status/int_clear registers in the usual way, and the EP side only tries to
> > > > > > > suppress needless edma_int as much as possible.
> > > > > > >
> > > > > > > That said, I'm now wondering if it would be better to set LIE=0/RIE=1 for
> > > > > > > the DMA transfer channels and LIE=1/RIE=0 for the notification channel.
> > > > > > > That would require some changes on dw-edma core.
> > > > > >
> > > > > > If dw-edma work as remote DMA, which should enable RIE. like
> > > > > > dw-edma-pcie.c, but not one actually use it recently.
> > > > > >
> > > > > > Use EDMA as doorbell should be new case and I think it is quite useful.
> > > > > >
> > > > > > > >
> > > > > > > > > +	struct ntb_edma_interrupt *v = data;
> > > > > > > > > +	u32 mask = BIT(EDMA_RD_CH_NUM);
> > > > > > > > > +	u32 i, val;
> > > > > > > > > +
> > > > > > ...
> > > > > > > > > +	ret = dw_edma_probe(chip);
> > > > > > > >
> > > > > > > > I think dw_edma_probe() should be in ntb_hw_epf.c, which provide DMA
> > > > > > > > dma engine support.
> > > > > > > >
> > > > > > > > EP side, suppose default dwc controller driver already setup edma engine,
> > > > > > > > so use correct filter function, you should get dma chan.
> > > > > > >
> > > > > > > I intentionally hid edma for EP side in .dts patch in [RFC PATCH v2 26/27]
> > > > > > > so that RC side only manages eDMA remotely and avoids the potential race
> > > > > > > condition I mentioned above.
> > > > > >
> > > > > > Improve eDMA core to suppport some dma channel work at local, some for
> > > > > > remote.
> > > > >
> > > > > Right, Firstly I experimented a bit more with different LIE/RIE settings and
> > > > > ended up with the following observations:
> > > > >
> > > > > * LIE=0/RIE=1 does not seem to work at the hardware level. When I tried this for
> > > > >   DMA transfer channels, the RC side never received any interrupt. The databook
> > > > >   (5.40a, 8.2.2 "Interrupts and Error Handling") has a hint that says
> > > > >   "If you want a remote interrupt and not a local interrupt then: Set LIE and
> > > > >   RIE [...]", so I think this behaviour is expected.
> > > >
> > > > Actually, you can append MSI write at last one of DMA descriptor link. So
> > > > it will not depend on eDMA's IRQ at all.
> > >
> > > For RC->EP interrupts on R-Car S4 in EP mode, using ITS_TRANSLATER as the
> > > IB iATU target did not appear to work in practice. Indeed that was the
> > > motivation for the RFC v1 series [2]. I have not tried using ITS_TRANSLATER
> > > as the eDMA read transfer DAR.
> > >
> > > But in any case, simply masking the local interrupt is sufficient here. I
> > > mainly wanted to point out that my naive idea of LIE=0/RIE=1 is not
> > > implementable with this hardware. This whole LIE/RIE topic is a bit
> > > off-track, sorry for the noise.
> > >
> > > [2] For the record, RFC v2 is conceptually orthogonal and introduces a
> > >     broader concept ie. remote eDMA model, but I reused many of the
> > >     preparatory commits from v1, which is why this is RFC v2 rather than a
> > >     separate series.
> > >
> > > >
> > > > > * LIE=1/RIE=0 does work at the hardware level, but is problematic for my current
> > > > >   design, where the RC issues the DMA transfer for the notification via
> > > > >   ntb_edma_notify_peer(). With RIE=0, the RC never calls
> > > > >   dw_edma_core_handle_int() for that channel, which means that internal state
> > > > >   such as dw_edma_chan.status is never managed correctly.
> > > >
> > > > If you append on MSI write at DMA link, you needn't check status register,
> > > > just check current LL pos to know which descrptor already done.
> > > >
> > > > Or you also enable LIE and disable related IRQ line(without register
> > > > irq handler), so Local IRQ will be ignore by GIC, you can safe handle at
> > > > RC side.
> > >
> > > What I was worried about here is that, with RIE=0 the current dw-edma
> > > handling of struct dw_edma_chan::status field (not status register) would
> > > not run for that channel, which could affect subsequent tx submissions. But
> > > your suggestion also makes sense, thank you.
> > >
> > > --8<--
> > >
> > > So anyway the key point seems that we should avoid such hard-coded register
> > > handling in [RFC PATCH v2 20/27] and rely only on the standard dw-edma
> > > interfaces (possibly with some extensions to the dw-edma core). From your
> > > feedback, I feel this is the essential direction.
> > >
> > > From that perspective, I'm leaning toward (b) (which I wrote above in a
> > > reply comment) with a Kconfig guard, i.e. in dw_pcie_ep_init_registers(),
> > > if IS_ENABLED(CONFIG_DW_REMOTE_EDMA) we only configure the notification
> > > channel. In practice, a DT-based variant of (b) (for example a new property
> > > such as "dma-notification-channel = <N>;" and making
> > > dw_pcie_ep_init_registers() honour it) would be very handy for users, but I
> > > suspect putting this kind of policy into DT is not acceptable.
> > >
> > > Assuming careful handling, (c) might actually be the simplest approach. I
> > > may need to add a small hook for the notification channel in
> > > dw_edma_done_interrupt(), via a new API such as
> > > dw_edma_chan_register_notify().
> >
> > I reply everything here for overall design
> >
> > EDMA actually can access all memory at both EP and RC side regardless PCI
> > map windows. NTB defination is that only access part of both system memory,
> > so anyway need once memcpy. Although NTB can't take 100% eDMA advantage, it
> > is still easiest path now. I have a draft idea without touch NTB core code
> > (most likley).
> >
> > EP side                          RC side
> >              1:  Control bar
> >              2:  Doorbell bar
> >              3:  WM1
> >
> > MW1 is fixed sized array [ntb_payload_header + data]. Current NTB built
> > queue in system memory, transfer data (RW) to this array.
> >
> > Use EDMA only one side, RC/EP. use EP as example.
> >
> > In 1 (control bar, resever memory space, which call B)
> >
> > In ntb_hw_epf.c driver, create a simple 'fake' DMA memcpy driver, which
> > just implement device_prep_dma_memcpy(). That just put src\dest\size info
> > to memory space B, then push doorbell.
> >
> > in EP side's a workqueue, fetch info from B, the send to EDMA queue to
> > do actual transfer, after EP DMA finish, mark done at B, then raise msi irq,
> > 'fake' DMA memcpy driver will be triggered.
> >
> > Futher, 3 WM1 is not necessary existed at all, because both side don't
> > access it directly.
> >
> > For example:
> >
> > case RC TX, EP RX
> >
> > RC ntb_async_tx_submit() use device_prep_dma_memcpy() copy user space
> > memory (0xRC_1000 to PCI_1000, size 0x1000), put into share bar0 position
> >
> >             0xRC_1000 -> 0xPCI_1000 0x1000
> >
> > EP side, there RX request ntb_async_rx_submit(),  from 0xPCI_1000 to
> > 0xEP_8000 size 0x20000.
> >
> > so setup eDMA transfer form 0xRC_1000 -> 0xEP_8000 size 1000. After complete
> > mark both side done, then trigger related callback functions.
> >
> > You can see 0xPCI_1000 is not used at all. Actually 0xPCI_1000 is trouble
> > maker,  RC and EP system PCI space is not necesary the same as CPU space,
> > PCI controller may do address convert.
>
> Thanks for the detailed explanation.
>
> Just to clarify, regarding your comments about the number of memcpy
> operations and not using the 0xPCI_1000 window for data path, I think RFC
> v2 is already similar to what you're describing.
>
> To me it seems the key differences in your proposal are mainly two-fold:
> (1) the layering, and (2) local eDMA use rather than remote.

Not big difference between remote and local DMA. My major means just use
oneside is enough. If eDMA handle in remote, EP side need virtual memcpy
and RC side to handle actual transfer.

I use EP as example, just because some logic R/W is reverted between EP/RC.
RC's write is EP's read.

>
> For (1), instead of adding more eDMA-specific handling into ntb_transport
> layer, your approach would keep changes to ntb_transport minimal and
> encapsulate the eDMA usage inside the "fake DMA memcpy driver" as much as
> possible. In that design, would the MW1 layout change? Leaving the existing
> layout as-is would waste the space (so RFC v2 had introduced a new layout).

It is fine if NTB maintainer agree it.

>
> Also, one point I'm still unsure about is the opposite direction (ie.
> EP->RC). In that case, do you also expect the EP to trigger its local eDMA
> engine? If yes, then, similar to the RC->EP direction in RFC v2, the EP
> would need to know the RC-side receive buffer address (e.g. 0xRC_1000) in
> advance.

'fake DMA memcpy driver' already put 0xRC_1000 to one shared memory place.

>
> You also mentioned that you already have some draft. Are you planning to
> post that as a patch series? If not, I can of course try to
> implement/prototype this approach based on your suggestion.

Sorry, I have not actually worked for ntb eDMA before. My work base on RDMA
framework. Idealy, RDMA can do user-space(EP) to user space (RC) data
transfer with zero copy.

But I think NTB is also a good path since RDMA is over complexed.

Frank

>
> Please let me know if the above understanding does not match what you had
> in mind.
>
> Thank you,
> Koichiro
>
>
> >
> > Frank
> > >
> > > Thank you for your time and review,
> > > Koichiro
> > >
> > > >
> > > > Frank
> > > > >
> > > > > >
> > > > > > Frank
> > > > > > >
> > > > > > > Thanks for reviewing,
> > > > > > > Koichiro
> > > > > > >
> > > > > > > >
> > > > > > > > Frank
> > > > > > > >
> > > > > > > > > +	if (ret) {
> > > > > > > > > +		dev_err(&ndev->dev, "dw_edma_probe failed: %d\n", ret);
> > > > > > > > > +		return ret;
> > > > > > > > > +	}
> > > > > > > > > +
> > > > > > > > > +	return 0;
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > ...
> > > > > >
> > > > > > > > > +{
> > > > > > > > > +	spin_lock_init(&qp->ep_tx_lock);
> > > > > > > > > +	spin_lock_init(&qp->ep_rx_lock);
> > > > > > > > > +	spin_lock_init(&qp->rc_lock);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > > +static const struct ntb_transport_backend_ops edma_backend_ops = {
> > > > > > > > > +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
> > > > > > > > > +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
> > > > > > > > > +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
> > > > > > > > > +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
> > > > > > > > > +	.rx_poll = ntb_transport_edma_rx_poll,
> > > > > > > > > +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
> > > > > > > > > +};
> > > > > > > > > +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> > > > > > > > > +
> > > > > > > > >  /**
> > > > > > > > >   * ntb_transport_link_up - Notify NTB transport of client readiness to use queue
> > > > > > > > >   * @qp: NTB transport layer queue to be enabled
> > > > > > > > > --
> > > > > > > > > 2.48.1
> > > > > > > > >

