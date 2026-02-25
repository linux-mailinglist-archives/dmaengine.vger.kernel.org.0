Return-Path: <dmaengine+bounces-9053-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMXmJjCznmlxWwQAu9opvQ
	(envelope-from <dmaengine+bounces-9053-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 09:30:40 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF99819432A
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 09:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B06E0301653A
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394031B839;
	Wed, 25 Feb 2026 08:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GFF+S7TX"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021078.outbound.protection.outlook.com [40.107.74.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D4131B82C;
	Wed, 25 Feb 2026 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772008238; cv=fail; b=haxZ2WFkwDtL+7x4WVGblWe5QFemjp2DRmfxPN/j3+SU7sFBztq6dbXNZgAyAduSDYrMueZ8al7Pk/ZnZcq59RrlYv0+Vew52h6yY+IBTTPphesO6i8E6UYy5yuZPF5TvQ1SSR9MzcBxzHS6LcsjaYOIMnXxLL25b+pqM72O1ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772008238; c=relaxed/simple;
	bh=dXeKqtye3EbL4jQNwNCtKy+sIyOwUNOwvz+GYI0/p88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hngid6IknyFolT9OCRQNtUEJDHOSsqaJhreaun0sWUBS1LoUBgUS7XVomMTFxHkjj8bCa9pfnGgAEcGEu4kr1VZBBgb4iY4lnu5JJ3NEDp1hTmIsUu3j6cIsYl+rwUcIGva6/vsJeETRLYT/tx8S8rEY29Uh6QRTiHxnU4Bhol8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GFF+S7TX; arc=fail smtp.client-ip=40.107.74.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asTTdaGKk09TGZgu9r0sVHHzI98aeSiwprkd6VSiWjJOhtcsX3pYMm8ceuCChkstUi91ZmkInv6JDzpWpx8FueDTh+tOn0asD9RUB7c78QPh/CVNlaZkMXFhZubZPh6A9uswMhDHBJj65ZJMSxljNv/7EUqMPXRB+H7vwGaCOIr7psfwWUu64srY3zLRj1DvHTbUehUDZ3Ml9eqsdTJSSbK6KKzjbqm52hiSE+c0MlAvmftWVDOeMjY7i9tsD+O/199TteKVTDyeyQJvgmnqd9MiJfJeabn/tZ7aUMcLqzFL/3eBsWKCtKPnshEI/Z1Yhh3n3pjn8WhKbjRoOrKU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ni78Dehiz6xLYgJL7WcjTkKfQoejn1NMV2lENGyPkvc=;
 b=XNf/+CxSJ5TqiDLovCIJHxyUu19wn98qS/IWM66zxA256LEPo25312GAbJs3gMuS7k6MBLhOZfvgY4g0ajSzNLXN/+YQxHFu+dvnxajzVPGpTIgD+AMpEesLEwLKMdm+khNyU8zbFCbHAk1QWvwbflVGjDApt8N286RFvVxQg0DZ6BkURX2SiqGGklYZxNVc8FOWOvKpmAXwAHUjGaziIdMq2kbyTSo//uftvCuUbE9iMLp9VQQgo7E5OUZLGr0lRCnBirMH66/CwAlk8oBQXl3aBgsIXnFGbR7wT65JXsKEXfvzvmflu0MvE/RsPUwJ6XcViDTRxU/fzVnSWESTtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ni78Dehiz6xLYgJL7WcjTkKfQoejn1NMV2lENGyPkvc=;
 b=GFF+S7TXQx0EaaUH4ufAfEb8G0cl3GvEvvuV0iNHrLfCTpkvpUPxRTQBuwBGH1Xv4xxiNeIdoYCf0w/DK1gXOVmukEtCapt8SPkYm2Gf99LmgMxOkWzgEHg4X/IN0cZT1RNLLj0QwcJCKdx2sxURhljICTMStuu3DQkHEr6Hdow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYTP286MB3897.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:187::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 08:30:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 08:30:34 +0000
Date: Wed, 25 Feb 2026 17:30:33 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.Li@nxp.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Christoph Hellwig <hch@lst.de>, Niklas Cassel <cassel@kernel.org>, dmaengine@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-nvme@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 04/11] dmaengine: dw-edma: Remove ll_max = -1 in
 dw_edma_channel_setup()
Message-ID: <6d6c222faypvbo6fvs7tad2gtzxqqzlsjkrbefwmgxodt5thbc@lylpaqxozrg7>
References: <20260109-edma_ll-v2-0-5c0b27b2c664@nxp.com>
 <20260109-edma_ll-v2-4-5c0b27b2c664@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-edma_ll-v2-4-5c0b27b2c664@nxp.com>
X-ClientProxiedBy: TY4PR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:405:372::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYTP286MB3897:EE_
X-MS-Office365-Filtering-Correlation-Id: e9deaa3e-118c-4863-7aee-08de744824e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7U8LW5UJfQtG86WI1G8Pq1mzRAt/gonsWpXeHworbBQxM4njoUZCaCNiU/dT?=
 =?us-ascii?Q?z/Zg8wut27TBgaSYMLCIxnp+R//2VqQJUF1Clil1PKgKCZJKTRujzOSUb1lB?=
 =?us-ascii?Q?BXOJmjqVTeXTsoX0b+iVES+U+OQdTpguNCDZzRqwP3z2wnkhhEsuh0AdvnuA?=
 =?us-ascii?Q?IUhLGHwpWS3PZpABO3PJQNU35Z6Ro8mcxfI2l8imvnznZJZx6tC/nx6aSxcU?=
 =?us-ascii?Q?V7wRtE9QsF8IpLL+/iDLQ2uQsmew61sowFTkDo2NuusfHs/wf0AjLK2q8iAX?=
 =?us-ascii?Q?sF79VXoArfKOnxVQIbw2kaYOLg5t6xSGItH3jz/AYjUlS6DgAoOoDJylcMQV?=
 =?us-ascii?Q?0GzI8q3uDH1b0bjiQ7u1QK5ewr39RATpSjJFsHXEA1c+HNmwaRmL/+NCfp7H?=
 =?us-ascii?Q?Iz6EGHiadElYO/rmN0S2ovuydOqm8oeOjA8ifhQ+jHUYrm7yJW7jEZ+0tlVW?=
 =?us-ascii?Q?4R2ue0ZMvbX0Tcx93Vl0FXnd2bscHmyrR9qBfHPQt6Y0CDOgpzTsNmc/hWAp?=
 =?us-ascii?Q?cC30fVA0gzzc2Lfl357rmli5CWUqeLb5/Ua9HfmAyqY/aaxNPepRzyPq4wQg?=
 =?us-ascii?Q?4VbHR7rWtY1dy6SNJSRhAhJ8HH6lUrvashXBIwteGzCaOPdybJURFE9CE9aP?=
 =?us-ascii?Q?UVWLgXiNOTZ8wpfoYROH33uGzSIzMYfGHtHtKJcmoZh3j+lb6ttG2C6aL+jB?=
 =?us-ascii?Q?l42kWgTgEKyiJp2CschOkHRIFbeSVgSv3M5pq10we0sUkooZK+tqasaB5y9E?=
 =?us-ascii?Q?abSdOWVdMMwV/TVULNtrpTJObwZd3jiAC2yOKgYgOwGZdP4NoN9lTivU35uz?=
 =?us-ascii?Q?c/QX13QT+GrXDM3JXN7w7E2WtRijrL13jg3o2JyFYmScHHT9K/alj/5qIBJv?=
 =?us-ascii?Q?iw9RgI5suVHPsUz3OdiuRCP00PgoisHgK7rg5LfNldn8lL+JApKY5bXHKYmo?=
 =?us-ascii?Q?dqdREQhh+LHanXEjhsJom8zjUGE8swJ9xdRYV3LFFeVFzJm3jjZWtyAkov9n?=
 =?us-ascii?Q?b1zCkRZE+a4JF36nJGZqupUG2/eRmBVhScbza3HGv5AXxuxfa2oOehIei03v?=
 =?us-ascii?Q?jDoY9+0qbhjTqFBiCmlUryAeXnGttFguhnPsy5qUp9CTJGzekUkGzhZvhFRI?=
 =?us-ascii?Q?UCDFlMrCIrLWyedt7aVRDLoPx656vH0kx2/W5yl5neKBvnGC22lWrSoQRhrF?=
 =?us-ascii?Q?jzElsQXz0empXZWgEIWZOW47fS9bzz7QSKwLS0W+ZHEzP+t4w6KRtzbX+yQM?=
 =?us-ascii?Q?Jvzc06nym6CstNZSTkX4Qa5QnraTbTPZh12be2s7VEXFXG3V6QGFFteTN6F3?=
 =?us-ascii?Q?mGo+7bJFJeJJrOkXWhM7IfVseOM2raf30simndqxyjyR22k3PjUZUfpU50d2?=
 =?us-ascii?Q?poNoizwHRkZBRSEeNiRdKU1PXuSqq+nNXFLH1DVwZDU/BR5pWUgejS8fUIte?=
 =?us-ascii?Q?o1mHczYInA5JwBtJM5AAiE/FqkJgnKHdI2Tl/SMI8qpLxb5LsiWuBz6lBrPH?=
 =?us-ascii?Q?qv+8y8D3BNjFVdjQUbQ3AcPXLfTHSbdSiWGwApGDm3Ors4Hmjr8X3EQ0lHr0?=
 =?us-ascii?Q?2zhGf+74C20gBpJtuKQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qf1kN4J/hlUo2KrBqqVlS07kwoZKjmJWjNRbxEZwS3+DYWzeDDyXAvo4YYwt?=
 =?us-ascii?Q?aZkEzKeA6rXr5sLWqf11HilmP2JoGR2lUkc/koJvKgaBdVEO7IlVOA4QjPu1?=
 =?us-ascii?Q?OzX31WTxXkWv7cL+cP1VEFsHFxNuZGauGNbUGUuySzXlPaVPnbqU7VKttn6Q?=
 =?us-ascii?Q?0uNqrt2i4OUoixnsUFmurDx4bpZ4EDNKaCzw9wcVLj3sqqcNK1jGIPVbCE2M?=
 =?us-ascii?Q?yjShWvG8aX+tFWMnq9QNsS7ToBcqJsAMNvJC88IUqmHb+0qxh1icEylaGxOP?=
 =?us-ascii?Q?jGeJS5/gJ2HaMCYqHcs4BkTyR8LGHW4mfmrxknfzyOvDovBVR7RCyDARyQdh?=
 =?us-ascii?Q?HZnNK6itHgGCvh+YIOl4Zez8hSpw0maLWYDWXoeHXU+PRSd0wHrS7lj2xVhn?=
 =?us-ascii?Q?ONwJuUp4rJF6i4mSgjjlhy+Rv+hFOhui5xyMvSfizng5S9uiwOsfghtzwUOS?=
 =?us-ascii?Q?MIkysrNR4/GVG5PgrPmXa38mXsDPJH1S3l/X3uSpMwHKZzkh7GkErke5xcpF?=
 =?us-ascii?Q?ljWk3vZgBPEUJuEnd6Odua3h8rkbbOJO7dgVGPY18QmMF1lp/oW72uamFC5C?=
 =?us-ascii?Q?Xtga7pKqtzOg/oIT+HlcKz1L1Xw59ej9GnrfPMl7kJs3tcT2kAGEGg4mybmj?=
 =?us-ascii?Q?LwhTP4VSAZF/QjPhzT2vrvI0raFRMlLD+fZ2BGzNx0kujx11MUFvwZjJk1Ou?=
 =?us-ascii?Q?EZZj7r1/MdmeoYN432S04G5kmMzOx/4z4bfbsRQ2l+WSMsJ/bdYj24GUhlL0?=
 =?us-ascii?Q?6e84r2MkmBvqzy+9Cjo7dTKtf3bKh5eXR9Sj5DxDwBHzGvwZaSdU9RGEZSZx?=
 =?us-ascii?Q?3grtyPE0V2TXMthdcaMfij+bbGDrjNNOHpYr2o9m9yUkTZMhPlyB5zB80j8O?=
 =?us-ascii?Q?5+Cxb/7fXzBf/qgvVzC/J6beYoMrFzr+13gBTJCsrAF75D4L0aOhqG93+lFp?=
 =?us-ascii?Q?GqUmEHCHDNO+yUwOXMhLEIe9p1V/Nx1ZA8avJ47VsuSO95xXcMcDQxalhsSW?=
 =?us-ascii?Q?oFI4gOQ3AGII0EgklZbtUfObKrve1NUG4h04tiXypuda3OkqaKYZEwGxlJX6?=
 =?us-ascii?Q?FnxbZGFWiEGaE1x0pejBQc2DOX6qRknQjCMPJ2cPnjZ023ME6F02VGYS8KwS?=
 =?us-ascii?Q?uJboI+CXK0QRPU/DVLky7wX0caUuolJwinvFs7RLAHjVdYT3ZrDswl0hvmsi?=
 =?us-ascii?Q?S74t620ZzazGTE0jkJ40hEkS7KwO9TJIKDysp9p9y4sbMhawnCoA5V6IV3vS?=
 =?us-ascii?Q?gVnyouDFxwjMMGVj0wOWc196FAv7a1X96JjoGPxxlsY315JQ0GsvuSkIcHhX?=
 =?us-ascii?Q?OqAZS6SX9QivXCLADOXev3Zv7/lJrrG0llWn6aNdyC9pmMmYwST7W+cKfGBs?=
 =?us-ascii?Q?Nw4DImWQqt0Bv/ZRO6bmH2KZHr8ChRwLu1cDHJvx8fWrTxjusAMIQz+yfBEX?=
 =?us-ascii?Q?SLrO02nYUJXYPa0o8x2gRlsFmN86YfANLRXtAxNLg3unAzAjBzqyZyi8nKSi?=
 =?us-ascii?Q?x2Ea0w6MxKNLuaWE+fZcON4xk2Q1KVlm0WKUhft+bq4HQTllxMbMqPr2m090?=
 =?us-ascii?Q?YznZ1Rutcm3RIsB+sZSXvSZhkHCFwoslSjX7xmdllcB4IJEevoE8mAAIia3o?=
 =?us-ascii?Q?g9bb3TrQeXo4P6L7doWAsThODYYDDqPoi8g7SWWxBvrlTjCqfx5AjXujDt6A?=
 =?us-ascii?Q?cvOsuvPZTmNcdgNnZh/C9Aerxd64oQ8B3E4eOTPYABmzdrr2vebuSW6zIWCg?=
 =?us-ascii?Q?W/ZtRNYMt1CC7TDuVPbxfesar4XnYzRYsNrP/HvftHM5/vF2e/CO?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e9deaa3e-118c-4863-7aee-08de744824e2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 08:30:33.9389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHkZojpeWt0+cPH9c5YHd/q9EOp5jv7uD+BhVYA2TFoD+7LgB5EIuPmMn5mMmEzeICn0PrIo6GHwSoQp6+X01g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3897
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9053-lists,dmaengine=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,valinux.co.jp:dkim,nxp.com:email]
X-Rspamd-Queue-Id: EF99819432A
X-Rspamd-Action: no action

On Fri, Jan 09, 2026 at 10:28:24AM -0500, Frank Li wrote:
> dw_edma_channel_setup() calculates ll_max based on the size of the
> ll_region, but the value is later overwritten with -1, preventing the
> code from ever reaching the calculated ll_max.
> 
> Typically ll_max is around 170 for a 4 KB page and four DMA R/W channels.
> It is uncommon for a single DMA request to reach this limit, so the issue
> has not been observed in practice. However, if it occurs, the driver may
> overwrite adjacent memory before reporting an error.
> 
> Remove the incorrect assignment so the calculated ll_max is honored
> 
> Fixes: 31fb8c1ff962d ("dmaengine: dw-edma: Improve the linked list and data blocks definition")
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c6b014949afe82f10362711fc8a956fe60a72835..b154bdd7f2897d9a28df698a425afc1b1c93698b 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -770,7 +770,6 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
>  		else
>  			chan->ll_max = (chip->ll_region_rd[chan->id].sz / EDMA_LL_SZ);
> -		chan->ll_max -= 1;

Just curious: wasn't this to reserve one slot for the final link element?

Best regards,
Koichiro

>  
>  		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
>  			 str_write_read(chan->dir == EDMA_DIR_WRITE),
> 
> -- 
> 2.34.1
> 

