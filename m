Return-Path: <dmaengine+bounces-8740-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDqiJkSIg2niowMAu9opvQ
	(envelope-from <dmaengine+bounces-8740-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:56:20 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D49EB43E
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDF2030090A8
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 17:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D561F3D411C;
	Wed,  4 Feb 2026 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rey252c8"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011010.outbound.protection.outlook.com [40.107.130.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7B934B691;
	Wed,  4 Feb 2026 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770227769; cv=fail; b=T/+zSOv760LAuPwfeeOmtPzTt2njv+P2lSs2bBI0wFrfJ2N+wi6i3X4tZb+KHMbEZqhEqI9TagRjYF4th59ZlG2HoLniU4bJcEnm4QqgBkObaIJtXiBJ7b10PMYV7BmIw6oItF/mEdmgtv9jv5QaWV4shNQjZ8NVC6bmfZ6dAAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770227769; c=relaxed/simple;
	bh=0tGVHkJUiHqy8xt3hrxcHl5uIOINfTEJ3WxsMyfpRqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CHlAA8XZLF23z4xkwmMK/Eu6gTGlHL8IM90ajuWUINS91j6B203um4nQXG6RF9IsdJ0t5Bky9gvwD76ZQ8hBwKtSgWIbHRMIOdAfkkGbgnWw5mOBOtZAN7fEf/oysqFtjnMne3xpoUDGjLzX4TePimR5DJlWZwFe1HwVRHvEoY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rey252c8; arc=fail smtp.client-ip=40.107.130.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3mKQyR3+xToplZFo4lAIZxh6QaL+N5/ApTTEUieDl7uVvT2dWd+mQ9E59DimjTXrQLQP1vaGo5j6bZZbegiThdlVPJGjlPPsgj5XfAKqPnG6Ss8xPenfa3cXEBIRuEI+jIdqIsAmCLZOBiaKD9xssmq/JKYMrcsGdIWznMc4rDNi2ixVJi0jGBZ4IiKBJCRGi+hDu+UE0Lj8sfz9C0z9UMZVEmR8WyYhA3OrOL+yAJucl769Ix/EBNVg2oyD13IemwbMrD6GxedU/0G8upzZIEn/6KdFz+ZMrkopDkW2kJaxicwuFJoNsTOyHgNr2nj67TE1lTkz810wEhfGnizQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXes3IJh+crnD84Loqo4tV48OEGr+DYaDTzEDl9ukSM=;
 b=x19rp43b3JecBP1ShFBtIoCH3EMSgumLHwjx5X8aZDrknRhS7o5FZEGKLGNjnucTGPBn27SRSSU48pXNv0VRSbAZb+QzQ+MmgEF/IqWaAx8H0gteHjmC3qDFAFKEmk0DhmrZsLrIZrxQ0cZ+UnKIshkLrBYcJrLfhkmNVUoqy4I4qWhfhHcw5L5Y48gTSsMqz+UTW4tzgeXhP2kqJKVqOLQ5j2980LKYFppbfjiV5Yn3pRAIULOE5Bu+Q/FPLznicE3PYYfaggbRXfN1GGmRav57/ESYqN/gX5Wed4TwJuURJDzF6S2bMZazNtuYRrbN6lIhJJ8lNA/d9wa6w6ulFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXes3IJh+crnD84Loqo4tV48OEGr+DYaDTzEDl9ukSM=;
 b=Rey252c81syue1KtEj6zau3Menf6TIuEXkhTquZCT49lLdpuQcbFIv9VyX1WsF+8Grb7XDnGVdy4D9C56zTrIj//jaj+9uk8yXnwpyff5hhgrkYwg6/lN0BjlipZOA6quQ08vpHvi+hL0USfxA87Sakpt079SkQ8LA2Bxxe9tUD9O7Vp1f/cLsad8kdvOlTIrLazV2z0yjzSdT57zvn5fpUNQc/fa6Lza1Zr2UvN9FpblisYaoKmHebMoS7I37f6M2OwsxMNO5VwXVBevGRTfwo0CtAP8sOTsUr4/Xad73abRg8kdbtViIq0tctosD3s8yQEULTxGL1gsg0yibhmDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB12153.eurprd04.prod.outlook.com (2603:10a6:800:316::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 17:56:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 17:56:06 +0000
Date: Wed, 4 Feb 2026 12:55:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/11] PCI: endpoint: Add remote resource query API
Message-ID: <aYOILtPYxazppfRD@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-7-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204145440.950609-7-den@valinux.co.jp>
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB12153:EE_
X-MS-Office365-Filtering-Correlation-Id: 670120a0-ec13-4fe9-58ca-08de6416ab50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|19092799006|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I73v70Vj7U/wVZl4lu6nfED0oiYLmldwiFG08jOheJevV3h+770ON0rxx7JK?=
 =?us-ascii?Q?JIPdjdc3uGWAonygX6BMcIIscJGOY4DkYNbIRg2+tbJ+i0F3AZ+G0v4hFMzd?=
 =?us-ascii?Q?SRo5CQfR38nY1FNGdl//0yd9e0ZoSTCFufQWxnZdwMQnMcWW/ohk4v9lWj49?=
 =?us-ascii?Q?pltGvz4jELsrIhnbhPukACvHCue2YHHuPbZbtY4a0pMYiwhl/xUCgfMmBQVV?=
 =?us-ascii?Q?P4+u1tzDPdSQjwuDgGaYsERLEv8qSVLni6GyKQAQaLza1pRYQ0mVOM73eka1?=
 =?us-ascii?Q?04ycQXLGygYyBtKNsrwudLb7gM16QvILG1zj7QtpIKuWVqMTHcqHSulk0ayJ?=
 =?us-ascii?Q?WeA6HJpw1/WPJ74xm2mSCmVGme8YjONCN/GzZUuKTfl3ZhY0S2dN+nJYrK8Q?=
 =?us-ascii?Q?ZIOLXhA/H3SQVnJk4Fyf6hTMAolp6Uonxoq6ith5SUgBrvCisJWwuSkrWgV7?=
 =?us-ascii?Q?VJfW7KydZX0YpVUbYZO9UpLPyK46MtkMfdUZL6eEJCWa4tB4wvaEBm03ug3D?=
 =?us-ascii?Q?A0ipGYzvr0eTLCjQpyxLJSlnjEizgJgYRJI2COp0YS9Bc9WW8kWdQRRZtha+?=
 =?us-ascii?Q?mTV+siL47zhVetq+PAsDnDKT0GkvpCiL8hG1NxZ0ogxN3CnrrCkCypvTO5qd?=
 =?us-ascii?Q?F+9sa5mtjB/5Q/qCh7/kRoG2ybaL5qLPx6Xs8Vq4Z8kW6mdH/rSRX7KgLCls?=
 =?us-ascii?Q?AcLqJW/i5ryAaUigYr+N3PbdYIxbGiVXooS68TTqPOpWB0cX1dDRYTVORQI3?=
 =?us-ascii?Q?ATYMnAGFbuVat2ew/R7mjS8VW3u7vTMwtQAvIxwlEuXhpjvpoNNHixamDkfG?=
 =?us-ascii?Q?MQry4SKk36p2g9sav4xENCx41BwpKEQA4LZGRSf7ViNkJUJNmVyf0EQ1zYve?=
 =?us-ascii?Q?8fgIrw5psUCmuDxSVa4SASCGaIF5dYApoNXXz54Bp5R5Qc9ktakhZHMW3W0N?=
 =?us-ascii?Q?yGDraBzlA8j7qsh6H2ai9wHjzHFY4ybVTNQEMdhCBiJGnix7ZvuY3QdnBue7?=
 =?us-ascii?Q?L1j36bPEK2CxNwb7JVQ4skeefx1QXtWw4oLvfGlsH0N7X08eXQwramqXKKZX?=
 =?us-ascii?Q?8Ny8lm76ajT/H/f3YSF8FVyO6UxGpxBlLjtqHPMdevCKtx1aAfrhmoyvRC0q?=
 =?us-ascii?Q?mwyl7iKDtpM/4GmisT4yC5fFeYu5RhUFuvzVIQtVZXAkSMNEEHDRSvcTMaru?=
 =?us-ascii?Q?5kIu1aMyfBNi+UAdhG6yvz2ijeorMfFXXV/TbUcf3Qz8RToOo+VIN7WJHvfJ?=
 =?us-ascii?Q?QaRX4eFKCWvtTiEOFe0qu1JK+6C9wnwRS94tE+6vK2DPwN7gPIzN9R5i3TCz?=
 =?us-ascii?Q?CH8Pe1fHBzrTKkglqR+rp9Mg5kaE3im+NsxGlCtVWhLwKmD+9LJezZ8GgwSb?=
 =?us-ascii?Q?axIzxLmkEl9vUMi7W3wLU7VdyZKE724tieGdJvctzmRiXt/AFkxPbpo15QI+?=
 =?us-ascii?Q?b0+2LchbKQxOMWn5De2+6kTbJJid+zOk1i5+2eN0gPn4VkkMTOZtGTvIH4MW?=
 =?us-ascii?Q?IgvKqMvIEUtLCW75N/rbHZqVwJ/iLDQOWmYBk76UXFJydEqVn/1iasAe2JXJ?=
 =?us-ascii?Q?yHt4feI0F+E20ZJ3gUbiNXNYI9Bn9SqGMqzd+QqOJmRy0LveVmNeJButeSFE?=
 =?us-ascii?Q?9qo3P9SCJGw04m6ApW/xHsA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(19092799006)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M1m3WJXa2b2/VIHlBuQxXnPF/j98sq4wbR73c82RW43iv9GWrFGOXeTEoLbq?=
 =?us-ascii?Q?eimUvR7JMYlbAH860AjHrhob5DFAi/Hw8e9pz4yDXJZwiWQRxeBOqSHuWb7E?=
 =?us-ascii?Q?1lDXhKW/NDxbmKY842J6I3WXKjw2N9eGY9KYKKuwIGt3yk3dKNhu6wTDe/6+?=
 =?us-ascii?Q?R/hfTiOwsZ+SLoGR29NH4PEKrRA7aPZ8pt3h1Yw2C+6fk4Pxkegf5WRgmX8/?=
 =?us-ascii?Q?QmPL4DO+rb4KX/2CMvuwnF/Csq8gkeONNyHFgzPm/KahNAQhdyYhinvwgZjM?=
 =?us-ascii?Q?46kyN+nBmYFFP0bFkPKMBbQpMfC9SLdmrlhU+oVqRehDIhzQl90htPz/SxVX?=
 =?us-ascii?Q?/dHvnRBKxT9zI7KPK+HuL4HxhIAr5bftQt0UE4fgf/7XudlAMah5cwyEVDLF?=
 =?us-ascii?Q?n6QB0+9yQe4SXFXsnNQcwy2C+7R4VjfmUH6mg8a8OFxyDRkdl/f88QRXzYKf?=
 =?us-ascii?Q?308m99cUpaI72Ps9DZo3h97oCudK75hGUG7goB+aX9XLITy08228F4u59ywJ?=
 =?us-ascii?Q?4KdDMkM2+fSjTdgqrC+APXqlPTlQ6c36JiH9lUkLsW0LFIebLKktY6KXcfWN?=
 =?us-ascii?Q?R/YB9lyoqqnbnxvJ2YB8r1dpCmgY01M4FI41R/OkNreM7hoIrYfBAgoMZxas?=
 =?us-ascii?Q?8mTifqPHdvgfqzAfZtw9uBZKqV3ppezcIyCZdtIwjaLZNHHYUMTx1fkOKMXC?=
 =?us-ascii?Q?kjfUQU+KcHbdujxoSJNSdMOcnXfEI2YJCeQhb+cBbFazp5xOzAFw2pEafhAa?=
 =?us-ascii?Q?55ZeqP7ti0r1mYGfZw4rDDOwP/2ErwiX4qI9o1cqVyvEB10RKKanoKsJkGph?=
 =?us-ascii?Q?3tp89wVUzjcZCllOqDRTpDUb29dotKh/+2KF8aPNpyl0euYFOtHyYmhXShh9?=
 =?us-ascii?Q?ucL7ggfmJ114ji+ZoGJaDn27/EEF0PEuOmoufCfp8kUVNRvxvj6KNZPTqlku?=
 =?us-ascii?Q?r4aCSEXcDNi0gTdm7rAnljY8sirTunyeoRieWjY7HrPNN3aMHifDF84+6alC?=
 =?us-ascii?Q?XfVLZEsTKhVmVH3G4DYLE5LcFG1JFoXvjigWboGbUGkQSyACLUJvDTUzoOts?=
 =?us-ascii?Q?Y1i6wWm4Kl4XeXhID0EsHwvk6sG0Bh/MyxPXfKFMfCllhdVWL/kRy4y+pj7F?=
 =?us-ascii?Q?LL4d0wYhhQIs2Wb+zN2jjB2GXWmZDDMLO3nkJItQHsEf7goUWAsH28f4Wemc?=
 =?us-ascii?Q?v+L132wcLdoZsZ3CYO8oBtJ2UXoAJ7dtcn8TnNob5p2whfnKJv33JigfFz4V?=
 =?us-ascii?Q?BufmN4DQnZXSW+IpTQhW/2TNBK+dOSqwoBpEi3tbIJOGMUrYWIz87m7bBsOL?=
 =?us-ascii?Q?sZzAkwEnHNWgORQwqBq8fgzRokoPMkkxu5qDj7M1I/lSOuPU7g2bWhDlLgzn?=
 =?us-ascii?Q?1eHo5nKLYROPJhqrnkj44uC6t3OD27dQqUOYR8+2PVz5xMoeTVBFztZIHqTa?=
 =?us-ascii?Q?vpqgYT9MzOJgf6z1psPt6duvAT06bJfNBV/CnJTEaAjTUMym0bQs58dUapKc?=
 =?us-ascii?Q?fNpgG2PmzfhutnUwvioOrzBrrDljXn2z1M/5KCSmuMK+mYDEPJwWwpQv8qZq?=
 =?us-ascii?Q?HaHxC2wcCwbqr2eH61dzqj51vd4MAIvIyjG58mH7/zXpV6FpgVKcNHR8KPHI?=
 =?us-ascii?Q?JPTwHSd0F4HQzW9QhngxRjNEcrSK/8XoMVQLGnKbrFFkK/+02NDT1lwogACu?=
 =?us-ascii?Q?dQyZniE0SQ2+EAMWfPJoAx5AYt62aCp9rAFAAQltzIn0MuOZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670120a0-ec13-4fe9-58ca-08de6416ab50
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:56:06.0855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuDGOG5722R/eKt8mNrPQM2QuMcHUhkTpKTVi+AmqzD/Q92+YAncqeHMhKaSyz+i9TfK4oLTy+4rP5zJ7+SBHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8740-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	URIBL_MULTI_FAIL(0.00)[valinux.co.jp:server fail];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 27D49EB43E
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:54:34PM +0900, Koichiro Den wrote:
> Endpoint controller drivers may integrate auxiliary blocks (e.g. DMA
> engines) whose register windows and descriptor memories metadata need to
> be exposed to a remote peer. Endpoint function drivers need a generic
> way to discover such resources without hard-coding controller-specific
> helpers.
>
> Add pci_epc_get_remote_resources() and the corresponding pci_epc_ops
> get_remote_resources() callback. The API returns a list of resources
> described by type, physical address and size, plus type-specific
> metadata.
>
> Passing resources == NULL (or num_resources == 0) returns the required
> number of entries.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/pci/endpoint/pci-epc-core.c | 41 +++++++++++++++++++++++++
>  include/linux/pci-epc.h             | 46 +++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+)
>
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 068155819c57..fa161113e24c 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -155,6 +155,47 @@ const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_get_features);
>
> +/**
> + * pci_epc_get_remote_resources() - query EPC-provided remote resources
> + * @epc: EPC device
> + * @func_no: function number
> + * @vfunc_no: virtual function number
> + * @resources: output array (may be NULL to query required count)
> + * @num_resources: size of @resources array in entries (0 when querying count)
> + *
> + * Some EPC backends integrate auxiliary blocks (e.g. DMA engines) whose control
> + * registers and/or descriptor memories can be exposed to the host by mapping
> + * them into BAR space. This helper queries the backend for such resources.
> + *
> + * Return:
> + *   * >= 0: number of resources returned (or required, if @resources is NULL)
> + *   * -EOPNOTSUPP: backend does not support remote resource queries
> + *   * other -errno on failure
> + */
> +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				 struct pci_epc_remote_resource *resources,
> +				 int num_resources)
> +{
> +	int ret;
> +
> +	if (!epc || !epc->ops)
> +		return -EINVAL;
> +
> +	if (func_no >= epc->max_functions)
> +		return -EINVAL;
> +
> +	if (!epc->ops->get_remote_resources)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&epc->lock);
> +	ret = epc->ops->get_remote_resources(epc, func_no, vfunc_no,
> +					     resources, num_resources);
> +	mutex_unlock(&epc->lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_get_remote_resources);
> +
>  /**
>   * pci_epc_stop() - stop the PCI link
>   * @epc: the link of the EPC device that has to be stopped
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index c021c7af175f..af60d4ad2f0e 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -61,6 +61,44 @@ struct pci_epc_map {
>  	void __iomem	*virt_addr;
>  };
>
> +/**
> + * enum pci_epc_remote_resource_type - remote resource type identifiers
> + * @PCI_EPC_RR_DMA_CTRL_MMIO: Integrated DMA controller register window (MMIO)
> + * @PCI_EPC_RR_DMA_CHAN_DESC: Per-channel DMA descriptor
> + *
> + * EPC backends may expose auxiliary blocks (e.g. DMA engines) by mapping their
> + * register windows and descriptor memories into BAR space. This enum
> + * identifies the type of each exposable resource.
> + */
> +enum pci_epc_remote_resource_type {
> +	PCI_EPC_RR_DMA_CTRL_MMIO,
> +	PCI_EPC_RR_DMA_CHAN_DESC,
> +};
> +
> +/**
> + * struct pci_epc_remote_resource - a physical resource that can be exposed
> + * @type:      resource type, see enum pci_epc_remote_resource_type
> + * @phys_addr: physical base address of the resource
> + * @size:      size of the resource in bytes
> + * @u:         type-specific metadata
> + *
> + * For @PCI_EPC_RR_DMA_CHAN_DESC, @u.dma_chan_desc provides per-channel
> + * information.
> + */
> +struct pci_epc_remote_resource {
> +	enum pci_epc_remote_resource_type type;
> +	phys_addr_t phys_addr;
> +	resource_size_t size;

is it good use struct resource?

> +
> +	union {
> +		/* PCI_EPC_RR_DMA_CHAN_DESC */
> +		struct {
> +			u16 hw_chan_id;
> +			bool ep2rc;
> +		} dma_chan_desc;
> +	} u;
> +};
> +
>  /**
>   * struct pci_epc_ops - set of function pointers for performing EPC operations
>   * @write_header: ops to populate configuration space header
> @@ -84,6 +122,8 @@ struct pci_epc_map {
>   * @start: ops to start the PCI link
>   * @stop: ops to stop the PCI link
>   * @get_features: ops to get the features supported by the EPC
> + * @get_remote_resources: ops to retrieve controller-owned resources that can be
> + *			  exposed to the remote host (optional)

Add comments, must set 'type' of pci_epc_remote_resource.

Over all it is good.

Frank
>   * @owner: the module owner containing the ops
>   */
>  struct pci_epc_ops {
> @@ -115,6 +155,9 @@ struct pci_epc_ops {
>  	void	(*stop)(struct pci_epc *epc);
>  	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
>  						       u8 func_no, u8 vfunc_no);
> +	int	(*get_remote_resources)(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +					struct pci_epc_remote_resource *resources,
> +					int num_resources);
>  	struct module *owner;
>  };
>
> @@ -309,6 +352,9 @@ int pci_epc_start(struct pci_epc *epc);
>  void pci_epc_stop(struct pci_epc *epc);
>  const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
>  						    u8 func_no, u8 vfunc_no);
> +int pci_epc_get_remote_resources(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
> +				 struct pci_epc_remote_resource *resources,
> +				 int num_resources);
>  enum pci_barno
>  pci_epc_get_first_free_bar(const struct pci_epc_features *epc_features);
>  enum pci_barno pci_epc_get_next_free_bar(const struct pci_epc_features
> --
> 2.51.0
>

