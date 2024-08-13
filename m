Return-Path: <dmaengine+bounces-2851-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8850C950528
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2024 14:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 416CC281051
	for <lists+dmaengine@lfdr.de>; Tue, 13 Aug 2024 12:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3AE19939D;
	Tue, 13 Aug 2024 12:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="TK454umH"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2095.outbound.protection.outlook.com [40.92.42.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80FB199246;
	Tue, 13 Aug 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723552634; cv=fail; b=owUmXhkiwXLpP8jgi4aCcWFUPekUn9AN9Teq0Eht4UmkaAJeuwCzh0XRpiLQfIV+WAauMe2N6DC5K585ytdzbchdYPclZy6Kq+v0U69FNQcRJbTCV5NBE4bYJB3s4UFVREqtmHb+PMwd0bmLS15YTmVKaJJAAi5cbjh9sAP8amk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723552634; c=relaxed/simple;
	bh=FmoBfuBey1fJP7KLDeDBKCJfzcBPwTJeZoosF5NXbMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VbokVnGA+k0ikjolkiD1bIknCLAQRTx4cZXJfGpNb3vh4VrZeFB0WwjP1bofM3OiuuHzbEGM3P/EEGNSbJONwAHkeeUkZkz+INd68eu+bTN+6iKQLH4pVfbPX49FAAC4F/q9flkrnEjGYohGk3rB1txB/cz4FmL/ZCVncByBr5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=TK454umH; arc=fail smtp.client-ip=40.92.42.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NB8zTqRWmS8DyjDPzlSxDzqsWHgWHBVx5H5/d+woklsRIuWst016ZDBpwrVZWZ1ksLpqEhew8RG9kUmck5iaV5B7AW7JgEbEQuKeyZVuOVIkzFNtj9cfddagreq4cJ2vzqTH8xjV3PbrxDGnoJ9Mh3rFF+Ce2zMxTnIdq46gMDqT1nxNqbxIj9TxCfDqxAgJXGVURw0MppilrctOzbpMb2OKxVDDcosCVc65Lf0TAeroJVGrS3VTB4XD8q43X8iO8qq6HuyeNj/+4C5hPgXOLednlt1XMWdN2NwgVEibKbM/QGmNELWSAlTDLIK8WcjFoaO2sxXsCuGGYG9bDZvbMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kz1wWtyQf3sB7iwIpFIHbT++lCODP7dAdhz/5A4kDWg=;
 b=KR5LdOKh3NbqveUHgt1TrKmtJCKueuHCgZsejw8FBtXEoSY1mnVCYDVxrcA1lCUNQKjAC+6h5nmUVvpwOLTBlaGZJgNgJC1YAGxDypZQZZvR9Izpjj58OtuJ762xa+SBo4NCACUQL6E6Ms+8pvFXuPG+hsspv9E0WMuH+WeQn4SMLIZz5IgpQ7ARyXF+qn4FAq91ZgRAuUim3hnFryzM6w0w5SeWR9kVt2Bup6mSjMhwVNPdEWfLIWL9WUxWRo42YsKkRqTkWLke1Drm0gAkW37j654CyZRBf0fzLwbCBr7gvRtxHX3H+1bvxgWhGm7Qkq1uEJAXRE2FqMX/uUQjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kz1wWtyQf3sB7iwIpFIHbT++lCODP7dAdhz/5A4kDWg=;
 b=TK454umHzZpVwrFB/1I7N5y+szso8ldCLJ6bv/GcBidZs+dOs7GB7Htz/elcwOTJxQWl2YnQ9ZSE6wq5gFbHBI+CJ5BpF+DmjdnjbXWD8WCwsWUrcb9py4bsW9AqPhb/d994WkHDY98KuHxInHx9cnfds2VZjKiRfp+G39sz8LHU5pgIAjqV6oAJcjhBHZkUNP/3aVQKGR5WCoxYdl8Yvtqbg+966E50AEyvSOc2iSUv07WaKDS+adFDnZVnUsKAsKU6Cuj7AU3OLhM0YEkDqe9N8ItIMNIOe7vbK+71iyy+oEvFh+jSFZdqnForwUAi6r9q30mbucevD3Wkqe7PKQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY5PR20MB4952.namprd20.prod.outlook.com (2603:10b6:930:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Tue, 13 Aug
 2024 12:37:10 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 12:37:10 +0000
Date: Tue, 13 Aug 2024 20:36:20 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v11 2/3] soc/sophgo: add top sysctrl layout file for
 CV18XX/SG200X
Message-ID:
 <IA1PR20MB49535F39821C284343A7F88FBB862@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495324F3EF7517562CB4CACFBB842@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB495384C4A2F64AE100350BE7BB842@IA1PR20MB4953.namprd20.prod.outlook.com>
 <ZrtOZIwszhJ9s8J2@matsya>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrtOZIwszhJ9s8J2@matsya>
X-TMN: [8vK+h7K227u9iXwTKohAgO94OS5y+ydWvhNpURSruAU=]
X-ClientProxiedBy: SI1PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <4o3emr4qu5hcf4idcdh33dxx2fkofpivbk3vgosixvyo7n52q7@26wj7ttxepco>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY5PR20MB4952:EE_
X-MS-Office365-Filtering-Correlation-Id: b9869291-d812-4aa2-0407-08dcbb94a69d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799003|8060799006|19110799003|5072599009|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	yL2Lql5S7c082fx4ELzp4Z1tJVrL7WGbWjgHU/TTH4aG+GkGzGYm73YFYDYFmY6With1oneCAI3A0WjCzddZZFUrPbXZrog+7rdEKpjO2LY8L6YltO0kG8GCbFw2+LkzjhrAoCpq8iF4jvtZr4l3+jk2wxJSjPC5EiEYE572cqcWxehYPgDHTyoJdDcbbxxq56oEtoWPhgutd6J92H1B2dNNn4rJtE44EUiEImO7ARK3TrifuV2LjKw/Avv0xzsk/9KfM3LGOdBdcchJpuy22xXu4M89EjZotGtk39xWwFF9LV2Z7rfLlhTXVjGOJuakmbOj4BUstKRTYIOWvWCuKUEkl7DRxVTf3z8/ehVRFbKtQkp9cgZQxl2vuEx930Aq+5HG6TU5NCpHLuth//CQZUj8a/zLoP0m3Q06TLdoWOHeFLxxBgzr6ztOs/Fazulvkr4chRVZZEqeyEj2Av2sipGoKHF+TIBOvzuU6JiSIVJouEPLSihV7A7oO1L9FvkD/GmOL0k3bNiSPN4OMy9sN19IdTDk8juiWp8nRcrUngWSLXGCICjudyIrwx5a9c1gaCpBdNFk/SBtZ6ISc/e8Ovw35hLHide9xbw082Zr6l1FBta/vpRSZkIOxUroKxRpN7NV21307/aMZBBXFO17Nz3vNH08V+/M0JsxAxD8ufz0TMIXGrhgg6GuPZkVjpOwPnTfON4bHi5bxteoVUqyxOdD5Ehjkk92NEkclOEcjOM=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?va8BKSwuG6uAUcEzoq/61BXm1k16CNwGUjvYdXfBQ46luPDxjLdeI22Ci04b?=
 =?us-ascii?Q?JH7mk1JBuoLTjzarRVtcD6L/Ihs4WlWseUCcIocLVeT6SmeKgPGkak65USpW?=
 =?us-ascii?Q?4jZwiaCvF6RMfBHltcG+aEnQjjfxH+/Q8/VpnBP7fbHu60m50JyD82ruJ8e5?=
 =?us-ascii?Q?xWdoauSX9aahg0/VOsQdSjySoUNFjcnVdTlutj7O7uep9CLmF43El2cd6Ymd?=
 =?us-ascii?Q?4/ImhwMY7XYrFCXTTsVgJJEofPGdv6vh5ob1Aq3vTG0oLOlwy+9EHLtyqTTQ?=
 =?us-ascii?Q?0OpySd6JWgKT/RuUR4OQTWpF9mB3aAjD+ypt9fu3OT1oObhHDyCLhbxXGMiT?=
 =?us-ascii?Q?RUBGMEOXGWW1axPEKblgR+x5JhJjWaHNzFKAp93DB+BMs0zMaJmgNSur9471?=
 =?us-ascii?Q?OmszXhFSRtLGrDm0R+3GHgoNh1NJJGxs6XcYWk45t8hosKTdM+eAY4M2mZ/T?=
 =?us-ascii?Q?NDxoZitPKLOKYCM4sLNmDHbxhvy8TNu499sjtvtCAMMbGoaNtK6/CZb7O1+n?=
 =?us-ascii?Q?KtRn3oBYUspUwDabCgFb5g+rXVNwGFEtrDC70gbBJhw4A7c5Aei2aE3NKYmR?=
 =?us-ascii?Q?XZYy/3RPrQqP8vsIBuXpGnzSoym2nVPkWSCLoaczuWjOqBIA/AnDGG6qrUl6?=
 =?us-ascii?Q?H+eIbic/Y+8KWN9qO0G68VpZsYbDxvnla6n09gdX1HfYxMi4IW7tWRoiKi+w?=
 =?us-ascii?Q?mQGyosNSdt9V1xnob65PQtR9deaZ+JP0BQkoFj1JggPsPppQ+EJxOdgl8z9+?=
 =?us-ascii?Q?cELcgymeeoaBMqK36WmK0krEsU/ZadFKfuABb1bxmgPXN1rQ+aIBSOnIoZK4?=
 =?us-ascii?Q?BSzq+hc3sJVmVW5dzn1y3MtpFVtymMtebNSsx0KzgTjP72BwNJiN971eIlny?=
 =?us-ascii?Q?pgjqAgTKiShJ8CFGoKlBtZn/CaWdKgIdqkyEKLaQMb2p5UHkuiegV+3kohsi?=
 =?us-ascii?Q?7swYHXc6C9xtrdMXRQN9i7GInmUva74MUZdBJyPYs77PAvVrAbErb5hvNkZW?=
 =?us-ascii?Q?B3inUJnAraQwHw/Uf7Cvhk6WwlFot9em73fEuUnp/G9YDmloFNg72X/K06XN?=
 =?us-ascii?Q?MvFyCK7krNuyDNcEo8plQiQi/MizLiiGd7yXrgJnDmEO78uQactCBLr/e9+5?=
 =?us-ascii?Q?emGpU13DhNJ5sKckdLp8/6p121Fs7fL923PEFwkiVUXFz+EZyrR945mqWvsq?=
 =?us-ascii?Q?9Q9aH9xnEM37IVYyjdn3NQP7F3jucysiGd9XJ9IP/FOWIzNRoJinGdYCHYrb?=
 =?us-ascii?Q?Qckkt56CPZJXVVJ7Q7uT?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9869291-d812-4aa2-0407-08dcbb94a69d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 12:37:10.6633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR20MB4952

On Tue, Aug 13, 2024 at 05:45:32PM GMT, Vinod Koul wrote:
> On 11-08-24, 13:16, Inochi Amaoto wrote:
> > The "top" system controller of CV18XX/SG200X exposes control
> > register access for various devices. Add soc header file to
> > describe it.
> 
> why define the full map and not just dma router offsets in a local dma
> header?

I added this map as a common file, so all the sub driver of the syscon
can use it. In my view, it is ok to just add necessary offset, but lost 
a generic view of the whole syscon device. So I choose adding a full
map.

Regard,
Inochi

