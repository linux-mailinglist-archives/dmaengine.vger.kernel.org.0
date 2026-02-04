Return-Path: <dmaengine+bounces-8738-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yECXHvKFg2niowMAu9opvQ
	(envelope-from <dmaengine+bounces-8738-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:46:26 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A633EB19A
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 18:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 736573077B9C
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 17:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00F834B69C;
	Wed,  4 Feb 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ta9GEX3+"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012017.outbound.protection.outlook.com [52.101.66.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18A3101B4;
	Wed,  4 Feb 2026 17:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226974; cv=fail; b=qcoa26DiekzFW+3+02QaG+G1tbFeeMbz6CwPlYEjqAx3lTm36d8w/tZMfLymojVK1mMK57ifXAUm3fJfqUx6qXrxMiPBPj+j3rUc0Exc77u5F16rSsUvLhdrx3uR7qS/B3SDXUdnV3ekviTrXmAY6Lg3ch/q+Yb0j7HqZwZFmzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226974; c=relaxed/simple;
	bh=hKbMo6q6s8wp1D+k4v2wDIPHakHRL1f/jjrpmN/lBFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QLGMYy0aY1dJSbfGb+zSqeC69kehlVAPf85mxEzqGM1CdbIUn00tfIJA3mrpDvMDHRYcw4fptQhGcS0vEk6eWi5/uY36mGfu8ExZG42NYzshBTzdxyqdNWKBXMH9AgTxNZoHA88YdQDlD4vU3YTmOGqSZ5yLj7vEMQ7Sp8yb7nQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ta9GEX3+; arc=fail smtp.client-ip=52.101.66.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTYSaozTHUloZoHqPWha88bXVXBDe5Au1zYmIT5WXwUJVnie1Aib7MJJXkeQw2J1de2USPu9LUrPidTGsY8r6m5FN1TpbA7WyzaAWtqLc7a/jUqkJa1V5KfcLj8om693Aw2rEEIQE5Zx2JxsFIOgUAEqR2j/8Pu6UnoOMXom3+1iKqO1R7PFzIbushK4Uk1rAlrINu/xdR66G/bMZyE55bGHKESDypqhP+4iOUkKhlddpTle5MrDVcKq/0pB4riuZ0+O6fVb9y58AUAKSKCKgoxKdHgU6/LB0ioS9wv6aDsKOMesYRgN+5R48DKyg43I+w031e2Vxv+ALInYoYWSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JY2kXv6YfOosoyOtzjAfevId+W6qt2yTBu4e75YxFuY=;
 b=umx5xd2UGz6Jtd9Ua5Yl6jGm/30SaCDhd+NN9s1eY5c9C78FXTThP2f6agl3+C0/j5M8CUAAQeiYpSCsmx0oI9zYsHEetgttBgd3J7VEpnN87WxQpAaANmn/Se+xH9doiB7214XUsOJkmYOK+QRT/GNWgTE3FSkiuIRv/cu4du5AzwssuZdZGfNV8VRo0oGE4Ww9Y5wLkIsQaEl8JJAXnEENa1k8ulMksbNXXqu/PkJbzP+O8D6qdlRd43sQTUywcxpzRaA86AhiGG2NHFWXMnaoy5Paa7TEYIkg0n3mpo++Nc+I3/BFwiECDr/iHc9e4Y3tf8p5QPMN+1bYvj7Geg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JY2kXv6YfOosoyOtzjAfevId+W6qt2yTBu4e75YxFuY=;
 b=Ta9GEX3+v+3gOMJSbwS8CDIoO10Wzznrt2q46MKon6Lh5TDBlmITDpFqMc4/dAF1T4flxpQ8zCXT+7bbnrvp8mnna9bwOsAR8Q2fg7jraCmkVxvLIKelw6e7cL6rHM7idyKUdPs2ndE0kZCW4Zy/neCIP6xpOVpFyKyxcqwjmXUT/0q0eiSxu0MYSILrJGdOrivMmY6hQ/uQMR4hTCIF3ecoWg/uEI2bLb9yRrj4L4I4bBPVgjn1L1qrdH9TYFUYsdvamBGTLyjoC/vhmKi0+d9qFJhwD94VL5519AO1NccUcxAkQaXMbg5968KN7m+BITxyvWxrF0hM204vT/hCRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9400.eurprd04.prod.outlook.com (2603:10a6:102:2b2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 17:42:50 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9587.010; Wed, 4 Feb 2026
 17:42:49 +0000
Date: Wed, 4 Feb 2026 12:42:41 -0500
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: vkoul@kernel.org, mani@kernel.org, jingoohan1@gmail.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
	bhelgaas@google.com, dmaengine@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/11] dmaengine: dw-edma: Add per-channel interrupt
 routing control
Message-ID: <aYOFEe-zyu4ZHTAl@lizhi-Precision-Tower-5810>
References: <20260204145440.950609-1-den@valinux.co.jp>
 <20260204145440.950609-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260204145440.950609-4-den@valinux.co.jp>
X-ClientProxiedBy: PH8P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:2d8::34) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9400:EE_
X-MS-Office365-Filtering-Correlation-Id: 4850d797-7ff7-436f-edcb-08de6414d06e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|52116014|376014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SmNUA8aJlRwv36EzJDNKG/wEPanBiHD/tJ7BQ//IsvutbMkWnEipZiW8U4/r?=
 =?us-ascii?Q?khByTtxVTgON64pDDRT2KP8CVb7avggqYG9z64cRCQMw6+kf98/IXy/ad9w9?=
 =?us-ascii?Q?/E/J63HDQwopVQdz83NeSMnBHqWx2UJ7wVN19P0eTJrCEc04zsNEUN+P0Xhj?=
 =?us-ascii?Q?zBGr98FjRGR7ehMC3t9nszP4QvjMXYXLPMgAzU5Byf79NqljakLUukXuZOUX?=
 =?us-ascii?Q?yKWl+TXqCKjhudf0iQG0DQDG9v2Mgj8iI6Kk7fscP+f4dJfGwetR97FPNRqS?=
 =?us-ascii?Q?0tpqrrLX+TC6gwRrOMIxjxtOTpwEZ6LayynfGqU2zExRLi+/B41bJaXvm5+Z?=
 =?us-ascii?Q?uMqJGs8IDJJcBL7BalAHPy4avXO4KKIL358m4sPevDHUIumUbfV3hqGGof8I?=
 =?us-ascii?Q?pbL1k8b3Z9p4D5KxLheC2cLEZGyW0jyFVrLo1a1pvcJInV/ht9LYApPiRTf8?=
 =?us-ascii?Q?0XpBtvmr5SemYsPuJCd79OPTEiKWfI26PbWKOVoKp6Oy3KEFKik+ZD0VCBs2?=
 =?us-ascii?Q?nCUQahgLD0JvY0FplmgWKpmeC8O9rof8Wq/wqKvuziL02QznFb24+WnTmRb0?=
 =?us-ascii?Q?ugIl6vFSC+Cb42ZvDnPaE9Q1HnO6dJR16Z8wgQF4kxKiLBJLHuFaSXn6WxOt?=
 =?us-ascii?Q?Ef+aFKg7zhcaCOYHYp/vrAOHS7qAJm2RvZNpfRz3dmIJ9kHbjM/dfh+3qd7O?=
 =?us-ascii?Q?PCmFmzKl1v/h5s+z8z1MPzmtYnayaWfmF0ZWxw8ek9v4sIDP7Gd4sMMWLeVc?=
 =?us-ascii?Q?gmHAhx4gBtJpm9WyfU9AQrQvm+EU5KowIbQWVMKmG+5wDNh4t7T3ATUSKLuX?=
 =?us-ascii?Q?6bogl/lXnPP4u7yzINTXn2iD2H3ObvWtFcCGWxhaVzdp1T9x0GWuAZbZJWtB?=
 =?us-ascii?Q?VBy9GTJ+s6Os+TX6JmGTeF272zTOGhqY/kUYstNE/zJnZWRdX4MNzLLEI0C1?=
 =?us-ascii?Q?JCMkib4jzStX3csZCX6oPCVqfU88Q8An+2dhVoDYlwdwVovTwYknWSfV7hoZ?=
 =?us-ascii?Q?Ld3rAtdIJ/Yspuckrx50KgRdqp5DV39oszO+w8bKrWh1Lkwd4rCdB2htbs/W?=
 =?us-ascii?Q?2Q24YRrzkeqJcVQ69ZDYKk6DmdQI5M0lvqOc1xcLSZSeNcc4Pgxp/tIqeaOs?=
 =?us-ascii?Q?9141KoFA0vZ5i1Zqxd2fFitcAxu/TkXueTFbSvkqKPpfYqAVsopOt6K91ZcA?=
 =?us-ascii?Q?quzHLRkbVKaQs7NxEC/FDwd1bJqVMceYsqcOssvSGfA9VP+AnSyy/cOG1MgR?=
 =?us-ascii?Q?F34zU6sHuFggR+RfQBVBvS3JxPqHhhFPrMr5IGFlYyoJMAs75Vesjwu+H4bQ?=
 =?us-ascii?Q?/ezrLjHX98iqu/oeUy12RKy6GoEFfzhGI0hhzroPm3FVv6lDgNZMf4cVtxwG?=
 =?us-ascii?Q?XKW+lpvpMe74wbePrkixkcyOSOxzUbruA1qy+LPM0sMx9ldRrr0D6JoJ4PeM?=
 =?us-ascii?Q?EE0VB47qFO1am8cETq22TL8jqymktajZf3PYSN62QcTlxIBlrg/tmdEoJXN6?=
 =?us-ascii?Q?Xnzo9XX/WOZUu+n+kn188F295EZolQO21Mb8LBsZghit7F0K4tuygwZNoM7s?=
 =?us-ascii?Q?H9yFNoaS2/ox8aK0u/rXMhIhVwmzhTX4nYS2t1Tlo0E8Xpom9tMSp1PXBIZv?=
 =?us-ascii?Q?vv2DchtVYYnFY33p0NXC7/E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GlYUjRVkJToJZBIAh9yTVDX8Wm6BDjc8uurQY+utNyG+s6DGQpyjTri9pG5W?=
 =?us-ascii?Q?3MPAbo74XH/+DvWu+7/f/C2msHPGhcLubxcsZvE9kTFCFWO5BUDI+zrq+q2X?=
 =?us-ascii?Q?vVAruLbC1HkrVi/sO17R6XQt9B/PLOXCskNnhdMHexgv/slSlKQm/WuFzhZZ?=
 =?us-ascii?Q?Ly3fNUWd5ZGNEAmBL2mnSwJIxL8AChlfHThZserTEN3uTrQ0itAXJd3iG51l?=
 =?us-ascii?Q?Of8QiDErXyvxEG5z3PS/Cday3QiORQ0/VHgyDVmdOSaAvp+PlqjKg0CoeeEm?=
 =?us-ascii?Q?zeHcC3CvEbIP23rCccir8LEwOXQoQGKWFpQQ9elLjM98pKVkG7fUK0MNJ9Ap?=
 =?us-ascii?Q?rpFSZRVuVnN67R8UgIoUcrj9UbX6Sf9twTheuLF9OMsSAB30/Zv3wbIklHaK?=
 =?us-ascii?Q?ONP+ufp3cRBXXX2YvaPJQW9e4bTNMz5qWu/HqDJbAi9q/jOu+U1m0G23/SbG?=
 =?us-ascii?Q?qYI1ALs2eS0KCHf/BrPH3Y+mFwDjnIAAVzSt7Wqc8GVxLE6yXmODz0XIhVbq?=
 =?us-ascii?Q?T/6kW4nbF6pVNQRqem799RRLLU8N7XvEH/QJfDBi2OAT/pL3KPAHlMsbZKbn?=
 =?us-ascii?Q?Lto5fde5iBsf13R3ojYBmNNY9/YvvEDElhmvFfKSuwQ1/BFVLhd0UCCAGkZ6?=
 =?us-ascii?Q?xFwMwZdcRZKBLobxqh3+1yZABHr8Cq13q4b3s9HPjlFeW1H6HkEaORHLhn6d?=
 =?us-ascii?Q?R3DgatMjhyGfJa0PVJRjFzP9IbZacO1J0jLMXTNQ3f2f5kQwMcOu4ZUTnAq2?=
 =?us-ascii?Q?VASa5JKnJLR2sjECore/mky+h3awy/jUk+SxonzL/B4whtkf7emg9JjF9anw?=
 =?us-ascii?Q?gRKNmLrE6dxOiROUecmgh7gwOMkAUipVxvSdzYl79SF33uy3mZuE56Eelutj?=
 =?us-ascii?Q?M6EzZdZ04PGvsffSH0tLn+ASIO6VcpyeO/HZ3ii4fG6wGg5tSInRntUph8a7?=
 =?us-ascii?Q?CcsEHgWSmo7p9UeCsroHhsNzn2SeOidUaThyBp/Av/xM9GBN2Bjv+h89PzRA?=
 =?us-ascii?Q?q4iVUu1xy+N5hAZg79uxdn6jV/j2MRsu9yYys2bws9IX2Wrw71Sdy3Lk4TZ8?=
 =?us-ascii?Q?VQ8H4vJgTYD3ZpHNPaw/xGMX8Rgls4bvY+kxw6Kxtn+mwG/zsiffCvU+m0U3?=
 =?us-ascii?Q?9Sn5++XEaN5IZr8YmR7nwRkXSvrw4+reFD3z1LA1vRkucuDNE8gSjoyqnOSr?=
 =?us-ascii?Q?R7fJYL+hmJrjX/WDRKtUZXM2bwPvu5xbfgHUyx+uoNTgJUpretIT0gnWB6un?=
 =?us-ascii?Q?OSYZhmkb+9nMbaDRReL7GOx+voV7OC0lU4dqIueY3d/cCdEGpY92KvZkbfHE?=
 =?us-ascii?Q?oM0NmxJbh2LxaAc7YsucgyKnrS7rlO8werw+PkkQizOrh0nIXYWVIN9taccW?=
 =?us-ascii?Q?n+LNSG8mKKlW4Jyd+TOAbRgLkSoUNTdzyGlYDi4XobitLM0EYPh2HVG80opy?=
 =?us-ascii?Q?KOnrv1hp7L8ofb+w8TQqkUdXvjXYO9Q4MuUeIgyXjYTrdiSQRA2vaD/0cbLl?=
 =?us-ascii?Q?5YJGcWbg8hf/9umvzm9ym3dnVjDTCLC0VTZe/AIfp8aWyiKkgTrmlHHRtjOy?=
 =?us-ascii?Q?eriVrbt4B0KY1469DiLKp2iQXlTFUIVXiuO0YY/1MuTkoQgdEhSQlUJlP7na?=
 =?us-ascii?Q?H6ylntkuh+fvMU83e9Hl3mrTbIiMAVxnhlRjvfyQMP02UrP2FTCitiqYqqF1?=
 =?us-ascii?Q?1nFwq44gIt33HHH+LlFD6pwoPVeuL/Aob0gzh0Ycb0gHol9n6XNCGRINr/qB?=
 =?us-ascii?Q?7F+ScRTrpg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4850d797-7ff7-436f-edcb-08de6414d06e
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 17:42:49.4554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avcpbLY05A32OxZ8WtkF02/GUnUDQ/YbDqhO6cKC23KN7DXfD2Z1d8xjsn6wftx9bi8/NHv/espJYa0mYrZ0mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9400
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8738-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,valinux.co.jp:email]
X-Rspamd-Queue-Id: 1A633EB19A
X-Rspamd-Action: no action

On Wed, Feb 04, 2026 at 11:54:31PM +0900, Koichiro Den wrote:
> DesignWare EP eDMA can generate interrupts both locally and remotely
> (LIE/RIE). Remote eDMA users need to decide, per channel, whether
> completions should be handled locally, remotely, or both. Unless
> carefully configured, the endpoint and host would race to ack the
> interrupt.
>
> Introduce a dw_edma_peripheral_config that holds per-channel interrupt
> routing mode. Update v0 programming so that RIE and local done/abort
> interrupt masking follow the selected mode. The default mode keeps the
> original behavior, so unless the new peripheral_config is explicitly
> used and set, no functional changes.
>
> For now, HDMA is not supported for the peripheral_config. Until the
> support is implemented and validated, explicitly reject it for HDMA to
> avoid silently misconfiguring interrupt routing.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c    | 24 +++++++++++++++++++++++
>  drivers/dma/dw-edma/dw-edma-core.h    | 13 +++++++++++++
>  drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++++++++++--------
>  include/linux/dma/edma.h              | 28 +++++++++++++++++++++++++++
>  4 files changed, 83 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 38832d9447fd..b4cb02d545bd 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -224,6 +224,29 @@ static int dw_edma_device_config(struct dma_chan *dchan,
>  				 struct dma_slave_config *config)
>  {
>  	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +	const struct dw_edma_peripheral_config *pcfg;
> +
> +	/* peripheral_config is optional, default keeps legacy behaviour. */
> +	chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
> +
> +	if (config->peripheral_config) {
> +		if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> +			return -EOPNOTSUPP;
> +
> +		if (config->peripheral_size < sizeof(*pcfg))
> +			return -EINVAL;

It is good to check here.

> +
> +		pcfg = config->peripheral_config;

save whole peripheral_config in case need more special peripheral
configuration in future.

> +		switch (pcfg->irq_mode) {
> +		case DW_EDMA_CH_IRQ_DEFAULT:
> +		case DW_EDMA_CH_IRQ_LOCAL:
> +		case DW_EDMA_CH_IRQ_REMOTE:
> +			chan->irq_mode = pcfg->irq_mode;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +	}

use helper function to get irq_mode. I posted combine config and prep by
one call.

https://lore.kernel.org/dmaengine/20260105-dma_prep_config-v3-0-a8480362fd42@nxp.com/

So we use such helper to get irq node after above patch merge. It is not
big deal, I can change it later. If provide helper funtions, it will be
slice better.

>
>  	memcpy(&chan->config, config, sizeof(*config));
>  	chan->configured = true;
> @@ -750,6 +773,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		chan->configured = false;
>  		chan->request = EDMA_REQ_NONE;
>  		chan->status = EDMA_ST_IDLE;
> +		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
>
>  		if (chan->dir == EDMA_DIR_WRITE)
>  			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
...
>
> +/*
> + * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
> + * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
> + * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0

keep consistent after "," for each enum

Frank

> + * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
> + *
> + * Some implementations require using LIE=1/RIE=1 with the local interrupt
> + * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
> + * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
> + * Write Interrupt Generation".
> + */
> +enum dw_edma_ch_irq_mode {
> +	DW_EDMA_CH_IRQ_DEFAULT	= 0,
> +	DW_EDMA_CH_IRQ_LOCAL,
> +	DW_EDMA_CH_IRQ_REMOTE,
> +};
> +
> +/**
> + * struct dw_edma_peripheral_config - dw-edma specific slave configuration
> + * @irq_mode: per-channel interrupt routing control.
> + *
> + * Pass this structure via dma_slave_config.peripheral_config and
> + * dma_slave_config.peripheral_size.
> + */
> +struct dw_edma_peripheral_config {
> +	enum dw_edma_ch_irq_mode irq_mode;
> +};
> +
>  /**
>   * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
>   * @dev:		 struct device of the eDMA controller
> --
> 2.51.0
>

