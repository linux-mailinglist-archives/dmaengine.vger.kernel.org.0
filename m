Return-Path: <dmaengine+bounces-8392-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yATABIqScGkaYgAAu9opvQ
	(envelope-from <dmaengine+bounces-8392-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 09:47:06 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD7A53CFD
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 09:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 64052625692
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jan 2026 11:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E20D3B5318;
	Tue, 20 Jan 2026 11:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dpWyt5c8"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010040.outbound.protection.outlook.com [52.101.193.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2123BC4DE;
	Tue, 20 Jan 2026 11:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768908978; cv=fail; b=Sh/jLfd6lySgp5+BvaRJMxSrxeuKxEXM+hSKeAbEDzUFXlb6cO0vrwCmj0PDeAXkskXfnde226loNUdrtyWGa0lQAxpUab16Sd0FvCEgnBM2FC0h+RnYWHa1a1j2byA6ZowOAOMqjCmCnqUvF6zXrVy3fWCUzn5aq6uFnWgPl8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768908978; c=relaxed/simple;
	bh=6iB6s53atCcRTMGLBqXvhs30VAv1gI6ibFShqyvRy7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pXWgNsAFBvOxvEiqRAc5FHM+LdSq52fa4c42TvTQ9X4PqqV4PdbgoQD4y3M1EfvrTPe7mvuTVH17jp++yZ500n7+hhOoIXlJ9g8/zUAmhsicMDA54qDx/FkmyijAGxcWJBxJEwz71bnHDTRUIj4ah0LLS3It8BErui37XVGMO5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dpWyt5c8; arc=fail smtp.client-ip=52.101.193.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToRM+bPFkU6+hKH7kaKr8Ksh7pPzT7NJmxlwZoNM76UnDi6nfOT89CAuB81DTxYRAvNx5WemF48pf3ugBGCO4t5Tv82YHiED90QIKMpl1deCrSL8+kvQMa+ITjMk2iSSEZvuNnWkxyo1TXlustEPoGPqQ9hNLh39GzHCHcwmSiLT0Ol27l40FBYZDTQW1yqCQGC+nfOVoxjXFpqocjElZ98XIxvrgGWUVKw6UNXZUXVJpbAagkOLaSCkN3Io4lMjV4f+6GlAW/+iffqZrth2uLJvdMso69bag2oQVeJUTsbnJ108eSKoOcnUyAM/gM+4jPiJj9eCm6CfVxTHcWHyOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWwEWpDx5Kx6mdC0Cc05UBfdbGqP3KVzafeacLAQhdQ=;
 b=ock+3tHsrmeehn1JlX1MO8F0EtfKDF1nwYjET8kEPdh1Sn/m0X0bZXpU8AmfNh2b5DCxSxYyWRphviVaz4qtPGJHfFVFZiswN8cuWwaq3Bgm+DpdE9DTFAZMzWMBp5+5R/uzpB4900iNOOdJB4mTbFstaVqwC0NWqwEQWzoewv/+WwDXGIOSCO7I+uEg0LqVn9xbuUTC3U90WvGnI0h+paTPEBhNGHhuApVXnDwMUef3ZDxzdS3uJYz9rB5aG/jTb0+nDTbaMkVwNd90QwzgSAcnQMZVbLTVg42LNkDre0ynQ6eqY/+2hb6/71luhX7k7mcF89/99Rt3fl2jpJd3mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWwEWpDx5Kx6mdC0Cc05UBfdbGqP3KVzafeacLAQhdQ=;
 b=dpWyt5c8rDxaKVBAwf+lOfp+21+6/vkkSCTGtZFUgoz0jtEB4Tk1OJNd02M8x6p+ZWu/1jKqgxgXv2rrXSXCaBXds4GrTAJKMRLNZzoDAHNIhly9Wjc/X9XfW36AtbuDp+frRj6ufko96cdj9G8Ov88P+4+24YfQhhK49asgQN0=
Received: from SA1PR12MB8120.namprd12.prod.outlook.com (2603:10b6:806:331::16)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.13; Tue, 20 Jan
 2026 11:36:11 +0000
Received: from SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3]) by SA1PR12MB8120.namprd12.prod.outlook.com
 ([fe80::2fd:1a4e:2042:7dd3%5]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 11:36:11 +0000
From: "Verma, Devendra" <Devendra.Verma@amd.com>
To: Frank Li <Frank.li@nxp.com>
CC: "bhelgaas@google.com" <bhelgaas@google.com>, "mani@kernel.org"
	<mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Simek,
 Michal" <michal.simek@amd.com>, "Verma, Devendra" <Devendra.Verma@amd.com>
Subject: RE: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Topic: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
Thread-Index: AQHcgWAk7pWjXdcU0UqtyDITzRPgzrVTd7gAgAE23OCABQPxgIABMzMA
Date: Tue, 20 Jan 2026 11:36:10 +0000
Message-ID:
 <SA1PR12MB8120F271FF381A78BEDCE6939589A@SA1PR12MB8120.namprd12.prod.outlook.com>
References: <20260109120354.306048-1-devendra.verma@amd.com>
 <20260109120354.306048-3-devendra.verma@amd.com>
 <aWkXyNzSsEB/LsVc@lizhi-Precision-Tower-5810>
 <SA1PR12MB8120D7666CAF07FE3CAEC9619588A@SA1PR12MB8120.namprd12.prod.outlook.com>
 <aW5RmbQ4qIJnAyHz@lizhi-Precision-Tower-5810>
In-Reply-To: <aW5RmbQ4qIJnAyHz@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-20T10:04:59.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB8120:EE_|PH7PR12MB8108:EE_
x-ms-office365-filtering-correlation-id: 071d38b6-8f8c-4722-255b-08de58181c4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WWp7a6Dp7LIsKrGIK/Y7y1A+sBYDuEuS1rdwOHX4y4ZF9NcPz1uj4BYrWR9H?=
 =?us-ascii?Q?kG66DZo++xo2GssRe6zXuK7IFGPcbbA5uoK3zxhJ2Zd6KjtPoy4fVw9OS3Wh?=
 =?us-ascii?Q?ysOTDCxx0wSJkSBFgXw1XK1SkQ4+UpBqjfBq4B44vRQdnGvfT3ciSgk4NKo1?=
 =?us-ascii?Q?oFP39qAPdGnxPePcNKEe/sNJWgawDX7Rq11tbBlrtSyKQIBCJayYJxTS7Ehw?=
 =?us-ascii?Q?qVG9UfhH7iomSTGMa3SVyAjxWWWC/V3IxfcqE2k7ZoxQqvIiDjuZdwUItKiI?=
 =?us-ascii?Q?XTbKiloLvOBGB3UTy+uQeOSacJfvhrpqcVv6QrcP62ammofW7WtHN8UEPXhJ?=
 =?us-ascii?Q?Mmnoid0483rVgy0Td/QQy9QK+ZDPoHcWF81AgOjadwMO80gr0gXeZvt0Qktk?=
 =?us-ascii?Q?zqCgKm7TcDoMMsXKEf5+URKe3fbnmKuPQPd0+R8osB+QcqQ7bkjWosn9+naD?=
 =?us-ascii?Q?vhbjIgLykmvv3anxFL7mSpmIvCx2Hbf3gHMxOKtYLYM7BY2pbHe7eqNxVm9t?=
 =?us-ascii?Q?nCnVXDqdvTrhJ24N60t9vwP/1pqkCL0REJzg4VA2skPKUdAzHyNGLG1uw4an?=
 =?us-ascii?Q?eK6XMrxgKEDMzz1grWgM1eW0QHtH19PlY/fL9PZRR31qPRHs/mw0t23NKw1g?=
 =?us-ascii?Q?ElzPnOkrVui/3liUizSMQvo2JAkNEKqH+0AI9VzZgrmtRYjLVafYDqkj8Qg8?=
 =?us-ascii?Q?1tYH+M9CgLyVMhLke56NPsZ7Cf7k27ceYd2FlMOLvsaICMP9L/0ZY6j+tEWZ?=
 =?us-ascii?Q?gyEAJjuIzBFD7S+rYGB35x9UYVYrGwByoRAdZQU9l1HmyOn9oZfQrzb0b/3C?=
 =?us-ascii?Q?pHWvmLnFYCRYo3E2EfkpUPH4bJVfJO1n8XXfGl8uh+zSTnNEMMMmZdwuVL3N?=
 =?us-ascii?Q?5W6JVrPXjC27hLyoksqUkmMdsAo/hliJfe9EfU1CmVGPqMWzs6TRCdOKYVOc?=
 =?us-ascii?Q?0+ZKZ8vkipmvuxggbLLJoxGqhkuqm/If3ktyJePSgahyyHbIuiKp+Rkhnw9d?=
 =?us-ascii?Q?ySeWb0VjZid912TX5ZeRd6reyogbsyP2bI/VVtjRp9iJEW6wrXS2N5f0UofL?=
 =?us-ascii?Q?pjid7yuorvzpKa6X20qpmwY1GZ04a4al7sJ7ZiG2qWMHf0CqXW8iNiPI2O5A?=
 =?us-ascii?Q?VzWmVIlf5tXyuGkfRyQom9DfZhT5bYMzMvgqJRZQjEmi7GGmU0XaI1DB5xzQ?=
 =?us-ascii?Q?MtgeycOvmp8c0NDJTVMhY7oJRt3vjpntokNNTjenlDfhxoA3W/BXwpNvp3X7?=
 =?us-ascii?Q?sQEP0+yk++juVInCrzS6SivQ+3Vl+YxyY6rEaMYg4n6d2Ky09o3MEUL+gnoU?=
 =?us-ascii?Q?ikJesKSWCvQgeH/fyhLee7ahUElohrFF8GYDOcOkGQ5BajfgVuy8Ue//1wY2?=
 =?us-ascii?Q?V9/pb5k0BsmVF5cpGBWdoxehVQb0BmiQxv9ruf2qTh5+0n7ojHxBBtgCPJsB?=
 =?us-ascii?Q?uQ90iwBFxAIB23YZW+pDkRq7MHsBlPf1vyLOh2d4PoDbXQFibvRQ6zLQen1z?=
 =?us-ascii?Q?hD5HhXkwXRycdtnb1G4GxyzevM41F/jKMGXrYSxSAxqbPDBrqjHw65Kk2Mrt?=
 =?us-ascii?Q?c1MLHDqV3FgQXKvrQkCnaGf1/fXRbVaH6vUJwp/iM0xIdrNcG0RPFRoxWWai?=
 =?us-ascii?Q?EI5DJEfzcUNg4VOmhJmEIyE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB8120.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XcHuphTp73khTsXfd8fE30AuZN1jnsBFFz9QodF6LLrYHA+D/VskuOrMf5eT?=
 =?us-ascii?Q?cl+FxXfeCkob/lIx/dKRP7Pu10qjKhg9H+U8Kn6tp3PFV59yV2LCAHH0kM2Q?=
 =?us-ascii?Q?fyuRXdjca0jODI98MvrWIt05RR18P1jB416QIpxksSlyLCApSQ9QWtT8JkgA?=
 =?us-ascii?Q?w/WCc15OL+x/VYfyS6t7iVRUMG9WC7UDwtl3RNFpmIJ87k2QdWRpYsfqFjQc?=
 =?us-ascii?Q?ZAC3ttfQZ8WYCuK0vMAQJUQOZeQ9yNOWn64z2feOjN0kdI7f3nnFSJtvyMx8?=
 =?us-ascii?Q?mUbpl8LTnvoiITyUuKTw+GeuuGNOKg5dbn3tIWbjFOupZ5wkAW0dsd0rqq0A?=
 =?us-ascii?Q?j8jgExxUst0tgmnvmA9m52Kfq0LWcPYe+0+GaIU7HtjoGXIWLIVEB9/aD9AP?=
 =?us-ascii?Q?AgKcAZ1g0TNICVKm5VPO8b76sPmv+2tlrDSkXUphEE2N5T1CXje3vMrvwzUG?=
 =?us-ascii?Q?a4kUaa1i2ch/T4NBnvJ6afUctbKzdWofg4SQimbOTfYlYNA6Axd2NStJctI/?=
 =?us-ascii?Q?rKJ1Rw/8ZFU8YEh+bvGagquom+A0t6EGqOR6N6IfTcxelSyozyLjEe6ai4ch?=
 =?us-ascii?Q?YDo1ujlsK8sYs6/xayXvpVS1lXKma3j6MR/CMo1ZjbngEVQM6joqDuigxOfL?=
 =?us-ascii?Q?I5UBXp76wv92sHUsV/ELFWc0kg36HIm8yCI4v1L8ZFXGbhWE//J1/i4w66hW?=
 =?us-ascii?Q?AynNwPVTkC7HpbNmTC5JghpUZ+BRTMBZMqMaqIaAAY/DpyTS37UkMvWL6rU2?=
 =?us-ascii?Q?cOv93uQoHv6Ss9W5v9yJLRosLDY5uiUuVUig7Gs4p7Z452V3SPtTrAeQw9zs?=
 =?us-ascii?Q?kuCCaV2/DumH4hAkFQNSEH0ZWU+aAwP0eIStQT/ihsLwaO5B0zOxlt2fuHvJ?=
 =?us-ascii?Q?172cOoqwFi0FOxhhJcs9BGTGdag1Apl7avZb9vMYRvFy8G+t8Tu6tVwDTBbm?=
 =?us-ascii?Q?Fxjx2PeEJ7oWAUqwFb43eJX8xyvbQFPaB1tCtkp5lYZkJAZtC8tLk+gNlmU9?=
 =?us-ascii?Q?z7ec61vNozWSmsEyUGkZqbcSB9XslkUQT3RK9XpHJxrhKx54eQYxA1p8MsVG?=
 =?us-ascii?Q?ck2JqrIbs/X6ZTYlHSGxw9j3sJql8hQPxuogRUjS+3719jlOod482Fgy69n4?=
 =?us-ascii?Q?rV3x9tS/vzQUuWCk2TyV2z+25PCgFvQSeulSfWjde/f8V9aN5IyKkQoHydPI?=
 =?us-ascii?Q?fOkzUdFA7J2Pu/zf0QYDjA7Mupvpw8ee1qr2swu8SfDLUjtpwywTkmKpkKeO?=
 =?us-ascii?Q?WnqR2IYApKzxR6xKTKT5BAAXel7cwaLeDMDG7pYY8g3yOYdbPXfRfnZWpacu?=
 =?us-ascii?Q?CBtQfld5Smuy1B4y5BPxJDgJ6YGkL3pkXvrDkjnOwaXV5ARZVBiBfnD1C1wc?=
 =?us-ascii?Q?TU7lH5EQgvXV9jiBO9pvtp/ygoLWGT1Xruuh9MmoOlObhg1hFqRDsbRrqEZI?=
 =?us-ascii?Q?1kL6N7uzAoV6R8YPaNoBbDHF5piKn/mSV1atWe+s46pVZKGvf9VZmuNWw+7h?=
 =?us-ascii?Q?ig2d4VFgX6mml6qbJXSgTfOmx107aQ1G2xP3spEn+mYitbkR7SvG6OEWSmdY?=
 =?us-ascii?Q?1U0rYPKpMY9h/774oKBvzxvNMvqm68O9stk0zLaF62dacxxQ4DRtRHBl4Be8?=
 =?us-ascii?Q?GvN6rjU3NI+AbjZMJZ2txKUm2hbnI1huc8oGm2tEFrVVLb+2oBBG9VytrXia?=
 =?us-ascii?Q?rLsC2eg4xMCi8Rv7TnmIjXF8KwyPTVdZLB3hi8hTQd5kfsuT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8120.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071d38b6-8f8c-4722-255b-08de58181c4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2026 11:36:10.9936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BsYZjiStjqqyKPzGKqam4udNUeSHXDkyJhmwJkB6x4F6ycm6x98SnsskKQzydDhL0+1VUAQ1kdwjFj/ep4yZWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[amd.com,quarantine];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8392-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Devendra.Verma@amd.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,SA1PR12MB8120.namprd12.prod.outlook.com:mid]
X-Rspamd-Queue-Id: AAD7A53CFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: Frank Li <Frank.li@nxp.com>
> Sent: Monday, January 19, 2026 9:15 PM
> To: Verma, Devendra <Devendra.Verma@amd.com>
> Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
>
> Caution: This message originated from an External Source. Use proper caut=
ion
> when opening attachments, clicking links, or responding.
>
>
> On Mon, Jan 19, 2026 at 09:09:17AM +0000, Verma, Devendra wrote:
> > [AMD Official Use Only - AMD Internal Distribution Only]
> >
> > Hi Frank
> >
> > Please check my response inline.
> >
> > Regards,
> > Devendra
> > > -----Original Message-----
> > > From: Frank Li <Frank.li@nxp.com>
> > > Sent: Thursday, January 15, 2026 10:07 PM
> > > To: Verma, Devendra <Devendra.Verma@amd.com>
> > > Cc: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org;
> > > dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>
> > > Subject: Re: [PATCH v8 2/2] dmaengine: dw-edma: Add non-LL mode
> > >
> > > Caution: This message originated from an External Source. Use proper
> > > caution when opening attachments, clicking links, or responding.
> > >
> > >
> > > On Fri, Jan 09, 2026 at 05:33:54PM +0530, Devendra K Verma wrote:
> > > > AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
> > > > The current code does not have the mechanisms to enable the DMA
> > > > transactions using the non-LL mode. The following two cases are
> > > > added with this patch:
> > > > - For the AMD (Xilinx) only, when a valid physical base address of
> > > >   the device side DDR is not configured, then the IP can still be
> > > >   used in non-LL mode. For all the channels DMA transactions will
> > >
> > > If DDR have not configured, where DATA send to in device side by
> > > non-LL mode.
> > >
> >
> > The DDR base address in the VSEC capability is used for driving the
> > DMA transfers when used in the LL mode. The DDR is configured and
> > present all the time but the DMA PCIe driver uses this DDR base
> > address (physical address) to configure the LLP address.
> >
> > In the scenario, where this DDR base address in VSEC capability is not
> > configured then the current controller cannot be used as the default
> > mode supported is LL mode only. In order to make the controller usable
> > non-LL mode is being added which just needs SAR, DAR, XFERLEN and
> > control register to initiate the transfer. So, the DDR is always
> > present, but the DMA PCIe driver need to know the DDR base physical
> > address to make the transfer. This is useful in scenarios where the mem=
ory
> allocated for LL can be used for DMA transactions as well.
>
> Do you means use DMA transfer LL's context?
>

Yes, the device side memory reserved for the link list to store the descrip=
tors,
accessed by the host via BAR_2 in this driver code.

> >
> > > >   be using the non-LL mode only. This, the default non-LL mode,
> > > >   is not applicable for Synopsys IP with the current code addition.
> > > >
> > > > - If the default mode is LL-mode, for both AMD (Xilinx) and Synosys=
,
> > > >   and if user wants to use non-LL mode then user can do so via
> > > >   configuring the peripheral_config param of dma_slave_config.
> > > >
> > > > Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
> > > > ---
> > > > Changes in v8
> > > >   Cosmetic change related to comment and code.
> > > >
> > > > Changes in v7
> > > >   No change
> > > >
> > > > Changes in v6
> > > >   Gave definition to bits used for channel configuration.
> > > >   Removed the comment related to doorbell.
> > > >
> > > > Changes in v5
> > > >   Variable name 'nollp' changed to 'non_ll'.
> > > >   In the dw_edma_device_config() WARN_ON replaced with dev_err().
> > > >   Comments follow the 80-column guideline.
> > > >
> > > > Changes in v4
> > > >   No change
> > > >
> > > > Changes in v3
> > > >   No change
> > > >
> > > > Changes in v2
> > > >   Reverted the function return type to u64 for
> > > >   dw_edma_get_phys_addr().
> > > >
> > > > Changes in v1
> > > >   Changed the function return type for dw_edma_get_phys_addr().
> > > >   Corrected the typo raised in review.
> > > > ---
> > > >  drivers/dma/dw-edma/dw-edma-core.c    | 42
> +++++++++++++++++++++---
> > > >  drivers/dma/dw-edma/dw-edma-core.h    |  1 +
> > > >  drivers/dma/dw-edma/dw-edma-pcie.c    | 46 ++++++++++++++++++--
> ------
> > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c | 61
> > > > ++++++++++++++++++++++++++++++++++-
> > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
> > >
> > > edma-v0-core.c have not update, if don't support, at least need
> > > return failure at dw_edma_device_config() when backend is eDMA.
> > >
> > > >  include/linux/dma/edma.h              |  1 +
> > > >  6 files changed, 132 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c
> > > > b/drivers/dma/dw-edma/dw-edma-core.c
> > > > index b43255f..d37112b 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > > > @@ -223,8 +223,32 @@ static int dw_edma_device_config(struct
> > > dma_chan *dchan,
> > > >                                struct dma_slave_config *config)  {
> > > >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(dchan);
> > > > +     int non_ll =3D 0;
> > > > +
> > > > +     if (config->peripheral_config &&
> > > > +         config->peripheral_size !=3D sizeof(int)) {
> > > > +             dev_err(dchan->device->dev,
> > > > +                     "config param peripheral size mismatch\n");
> > > > +             return -EINVAL;
> > > > +     }
> > > >
> > > >       memcpy(&chan->config, config, sizeof(*config));
> > > > +
> > > > +     /*
> > > > +      * When there is no valid LLP base address available then the=
 default
> > > > +      * DMA ops will use the non-LL mode.
> > > > +      *
> > > > +      * Cases where LL mode is enabled and client wants to use the=
 non-LL
> > > > +      * mode then also client can do so via providing the peripher=
al_config
> > > > +      * param.
> > > > +      */
> > > > +     if (config->peripheral_config)
> > > > +             non_ll =3D *(int *)config->peripheral_config;
> > > > +
> > > > +     chan->non_ll =3D false;
> > > > +     if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non=
_ll))
> > > > +             chan->non_ll =3D true;
> > > > +
> > > >       chan->configured =3D true;
> > > >
> > > >       return 0;
> > > > @@ -353,7 +377,7 @@ static void
> > > > dw_edma_device_issue_pending(struct
> > > dma_chan *dchan)
> > > >       struct dw_edma_chan *chan =3D dchan2dw_edma_chan(xfer->dchan)=
;
> > > >       enum dma_transfer_direction dir =3D xfer->direction;
> > > >       struct scatterlist *sg =3D NULL;
> > > > -     struct dw_edma_chunk *chunk;
> > > > +     struct dw_edma_chunk *chunk =3D NULL;
> > > >       struct dw_edma_burst *burst;
> > > >       struct dw_edma_desc *desc;
> > > >       u64 src_addr, dst_addr;
> > > > @@ -419,9 +443,11 @@ static void
> > > > dw_edma_device_issue_pending(struct
> > > dma_chan *dchan)
> > > >       if (unlikely(!desc))
> > > >               goto err_alloc;
> > > >
> > > > -     chunk =3D dw_edma_alloc_chunk(desc);
> > > > -     if (unlikely(!chunk))
> > > > -             goto err_alloc;
> > > > +     if (!chan->non_ll) {
> > > > +             chunk =3D dw_edma_alloc_chunk(desc);
> > > > +             if (unlikely(!chunk))
> > > > +                     goto err_alloc;
> > > > +     }
> > >
> > > non_ll is the same as ll_max =3D 1. (or 2, there are link back entry)=
.
> > >
> > > If you set ll_max =3D 1, needn't change this code.
> > >
> >
> > The ll_max is defined for the session till the driver is loaded in the =
kernel.
> > This code also enables the non-LL mode dynamically upon input from the
> > DMA client. In this scenario, touching ll_max would not be a good idea
> > as the ll_max controls the LL entries for all the DMA channels not
> > just for a single DMA transaction.
>
> You can use new variable, such as ll_avail.
>

In order to separate out the execution paths a new meaningful variable "non=
_ll"
is used. The variable "non_ll" alone is sufficient. Using another variable
along side "non_ll" for the similar purpose may not have any added advantag=
e.

> >
> > > >
> > > >       if (xfer->type =3D=3D EDMA_XFER_INTERLEAVED) {
> > > >               src_addr =3D xfer->xfer.il->src_start; @@ -450,7
> > > > +476,13 @@ static void dw_edma_device_issue_pending(struct
> dma_chan *dchan)
> > > >               if (xfer->type =3D=3D EDMA_XFER_SCATTER_GATHER && !sg=
)
> > > >                       break;
> > > >
> > > > -             if (chunk->bursts_alloc =3D=3D chan->ll_max) {
> > > > +             /*
> > > > +              * For non-LL mode, only a single burst can be handle=
d
> > > > +              * in a single chunk unlike LL mode where multiple bu=
rsts
> > > > +              * can be configured in a single chunk.
> > > > +              */
> > > > +             if ((chunk && chunk->bursts_alloc =3D=3D chan->ll_max=
) ||
> > > > +                 chan->non_ll) {
> > > >                       chunk =3D dw_edma_alloc_chunk(desc);
> > > >                       if (unlikely(!chunk))
> > > >                               goto err_alloc; diff --git
> > > > a/drivers/dma/dw-edma/dw-edma-core.h
> > > > b/drivers/dma/dw-edma/dw-edma-core.h
> > > > index 71894b9..c8e3d19 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-core.h
> > > > +++ b/drivers/dma/dw-edma/dw-edma-core.h
> > > > @@ -86,6 +86,7 @@ struct dw_edma_chan {
> > > >       u8                              configured;
> > > >
> > > >       struct dma_slave_config         config;
> > > > +     bool                            non_ll;
> > > >  };
> > > >
> > > >  struct dw_edma_irq {
> > > > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > index 2efd149..277ca50 100644
> > > > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > > > @@ -298,6 +298,15 @@ static void
> > > dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
> > > >       pdata->devmem_phys_off =3D off;  }
> > > >
> > > > +static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
> > > > +                              struct dw_edma_pcie_data *pdata,
> > > > +                              enum pci_barno bar) {
> > > > +     if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX)
> > > > +             return pdata->devmem_phys_off;
> > > > +     return pci_bus_address(pdev, bar); }
> > > > +
> > > >  static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > >                             const struct pci_device_id *pid)  { @@
> > > > -307,6 +316,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev=
,
> > > >       struct dw_edma_chip *chip;
> > > >       int err, nr_irqs;
> > > >       int i, mask;
> > > > +     bool non_ll =3D false;
> > > >
> > > >       vsec_data =3D kmalloc(sizeof(*vsec_data), GFP_KERNEL);
> > > >       if (!vsec_data)
> > > > @@ -331,21 +341,24 @@ static int dw_edma_pcie_probe(struct
> pci_dev
> > > *pdev,
> > > >       if (pdev->vendor =3D=3D PCI_VENDOR_ID_XILINX) {
> > > >               /*
> > > >                * There is no valid address found for the LL memory
> > > > -              * space on the device side.
> > > > +              * space on the device side. In the absence of LL bas=
e
> > > > +              * address use the non-LL mode or simple mode support=
ed by
> > > > +              * the HDMA IP.
> > > >                */
> > > > -             if (vsec_data->devmem_phys_off =3D=3D
> > > DW_PCIE_XILINX_MDB_INVALID_ADDR)
> > > > -                     return -ENOMEM;
> > > > +             if (vsec_data->devmem_phys_off =3D=3D
> > > DW_PCIE_AMD_MDB_INVALID_ADDR)
> > > > +                     non_ll =3D true;
> > > >
> > > >               /*
> > > >                * Configure the channel LL and data blocks if number=
 of
> > > >                * channels enabled in VSEC capability are more than =
the
> > > >                * channels configured in xilinx_mdb_data.
> > > >                */
> > > > -             dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
> > > > -                                            DW_PCIE_XILINX_MDB_LL_=
OFF_GAP,
> > > > -                                            DW_PCIE_XILINX_MDB_LL_=
SIZE,
> > > > -                                            DW_PCIE_XILINX_MDB_DT_=
OFF_GAP,
> > > > -                                            DW_PCIE_XILINX_MDB_DT_=
SIZE);
> > > > +             if (!non_ll)
> > > > +                     dw_edma_set_chan_region_offset(vsec_data, BAR=
_2, 0,
> > > > +                                                    DW_PCIE_XILINX=
_LL_OFF_GAP,
> > > > +                                                    DW_PCIE_XILINX=
_LL_SIZE,
> > > > +
> > > > + DW_PCIE_XILINX_DT_OFF_GAP,
> > > > +
> > > > + DW_PCIE_XILINX_DT_SIZE);
> > > >       }
> > > >
> > > >       /* Mapping PCI BAR regions */ @@ -393,6 +406,7 @@ static int
> > > > dw_edma_pcie_probe(struct pci_dev
> > > *pdev,
> > > >       chip->mf =3D vsec_data->mf;
> > > >       chip->nr_irqs =3D nr_irqs;
> > > >       chip->ops =3D &dw_edma_pcie_plat_ops;
> > > > +     chip->non_ll =3D non_ll;
> > > >
> > > >       chip->ll_wr_cnt =3D vsec_data->wr_ch_cnt;
> > > >       chip->ll_rd_cnt =3D vsec_data->rd_ch_cnt; @@ -401,7 +415,7 @@
> > > > static int dw_edma_pcie_probe(struct pci_dev *pdev,
> > > >       if (!chip->reg_base)
> > > >               return -ENOMEM;
> > > >
> > > > -     for (i =3D 0; i < chip->ll_wr_cnt; i++) {
> > > > +     for (i =3D 0; i < chip->ll_wr_cnt && !non_ll; i++) {
> > > >               struct dw_edma_region *ll_region =3D &chip->ll_region=
_wr[i];
> > > >               struct dw_edma_region *dt_region =3D &chip->dt_region=
_wr[i];
> > > >               struct dw_edma_block *ll_block =3D
> > > > &vsec_data->ll_wr[i]; @@ -412,7 +426,8 @@ static int
> > > > dw_edma_pcie_probe(struct pci_dev
> > > *pdev,
> > > >                       return -ENOMEM;
> > > >
> > > >               ll_region->vaddr.io +=3D ll_block->off;
> > > > -             ll_region->paddr =3D pci_bus_address(pdev, ll_block->=
bar);
> > > > +             ll_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec=
_data,
> > > > +
> > > > + ll_block->bar);
> > >
> > > This change need do prepare patch, which only change
> > > pci_bus_address() to dw_edma_get_phys_addr().
> > >
> >
> > This is not clear.
>
> why not. only trivial add helper patch, which help reviewer
>

I was not clear on the question you asked.
It does not look justified when a patch is raised alone just to replace thi=
s function.
The function change is required cause the same code *can* support different=
 IPs from
different vendors. And, with this single change alone in the code the suppo=
rt for another
IP is added. That's why it is easier to get the reason for the change in
the function name and syntax.

> >
> > > >               ll_region->paddr +=3D ll_block->off;
> > > >               ll_region->sz =3D ll_block->sz;
> > > >
> > > > @@ -421,12 +436,13 @@ static int dw_edma_pcie_probe(struct
> pci_dev
> > > *pdev,
> > > >                       return -ENOMEM;
> > > >
> > > >               dt_region->vaddr.io +=3D dt_block->off;
> > > > -             dt_region->paddr =3D pci_bus_address(pdev, dt_block->=
bar);
> > > > +             dt_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec=
_data,
> > > > +
> > > > + dt_block->bar);
> > > >               dt_region->paddr +=3D dt_block->off;
> > > >               dt_region->sz =3D dt_block->sz;
> > > >       }
> > > >
> > > > -     for (i =3D 0; i < chip->ll_rd_cnt; i++) {
> > > > +     for (i =3D 0; i < chip->ll_rd_cnt && !non_ll; i++) {
> > > >               struct dw_edma_region *ll_region =3D &chip->ll_region=
_rd[i];
> > > >               struct dw_edma_region *dt_region =3D &chip->dt_region=
_rd[i];
> > > >               struct dw_edma_block *ll_block =3D
> > > > &vsec_data->ll_rd[i]; @@ -437,7 +453,8 @@ static int
> > > > dw_edma_pcie_probe(struct pci_dev
> > > *pdev,
> > > >                       return -ENOMEM;
> > > >
> > > >               ll_region->vaddr.io +=3D ll_block->off;
> > > > -             ll_region->paddr =3D pci_bus_address(pdev, ll_block->=
bar);
> > > > +             ll_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec=
_data,
> > > > +
> > > > + ll_block->bar);
> > > >               ll_region->paddr +=3D ll_block->off;
> > > >               ll_region->sz =3D ll_block->sz;
> > > >
> > > > @@ -446,7 +463,8 @@ static int dw_edma_pcie_probe(struct pci_dev
> > > *pdev,
> > > >                       return -ENOMEM;
> > > >
> > > >               dt_region->vaddr.io +=3D dt_block->off;
> > > > -             dt_region->paddr =3D pci_bus_address(pdev, dt_block->=
bar);
> > > > +             dt_region->paddr =3D dw_edma_get_phys_addr(pdev, vsec=
_data,
> > > > +
> > > > + dt_block->bar);
> > > >               dt_region->paddr +=3D dt_block->off;
> > > >               dt_region->sz =3D dt_block->sz;
> > > >       }
> > > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > > b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > > index e3f8db4..a5d12bc 100644
> > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > > @@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct
> > > dw_edma_chunk *chunk)
> > > >               readl(chunk->ll_region.vaddr.io);  }
> > > >
> > > > -static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk,
> > > > bool
> > > > first)
> > > > +static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk,
> > > > +bool first)
> > > >  {
> > > >       struct dw_edma_chan *chan =3D chunk->chan;
> > > >       struct dw_edma *dw =3D chan->dw; @@ -263,6 +263,65 @@ static
> > > > void dw_hdma_v0_core_start(struct
> > > dw_edma_chunk *chunk, bool first)
> > > >       SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > > HDMA_V0_DOORBELL_START);  }
> > > >
> > > > +static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk
> > > *chunk)
> > > > +{
> > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > +     struct dw_edma *dw =3D chan->dw;
> > > > +     struct dw_edma_burst *child;
> > > > +     u32 val;
> > > > +
> > > > +     list_for_each_entry(child, &chunk->burst->list, list) {
> > >
> > > why need iterated list, it doesn't support ll. Need wait for irq to s=
tart next
> one.
> > >
> > > Frank
> >
> > Yes, this is true. The format is kept similar to LL mode.
>
> Just fill one. list_for_each_entry() cause confuse.
>
> Frank

I see, we can use list_first_entry_or_null() which is dependent on giving
the type of pointer, compared to this list_for_each_entry() looks neat and
agnostic to the pointer type being used. Though, it can be explored further=
.
Also, when the chunk is allocated, the comment clearly spells out how
the allocation would be for the non LL mode so it is evident that each
chunk would have single entry and with that understanding it is clear that
loop will also be used in a similar manner, to retrieve a single entry. It =
is a
similar use case as of "do {}while (0)" albeit needs a context to understan=
d it.

> >
> > >
> > > > +             SET_CH_32(dw, chan->dir, chan->id, ch_en,
> > > > + HDMA_V0_CH_EN);
> > > > +
> > > > +             /* Source address */
> > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
> > > > +                       lower_32_bits(child->sar));
> > > > +             SET_CH_32(dw, chan->dir, chan->id, sar.msb,
> > > > +                       upper_32_bits(child->sar));
> > > > +
> > > > +             /* Destination address */
> > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
> > > > +                       lower_32_bits(child->dar));
> > > > +             SET_CH_32(dw, chan->dir, chan->id, dar.msb,
> > > > +                       upper_32_bits(child->dar));
> > > > +
> > > > +             /* Transfer size */
> > > > +             SET_CH_32(dw, chan->dir, chan->id, transfer_size,
> > > > + child->sz);
> > > > +
> > > > +             /* Interrupt setup */
> > > > +             val =3D GET_CH_32(dw, chan->dir, chan->id, int_setup)=
 |
> > > > +                             HDMA_V0_STOP_INT_MASK |
> > > > +                             HDMA_V0_ABORT_INT_MASK |
> > > > +                             HDMA_V0_LOCAL_STOP_INT_EN |
> > > > +                             HDMA_V0_LOCAL_ABORT_INT_EN;
> > > > +
> > > > +             if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
> > > > +                     val |=3D HDMA_V0_REMOTE_STOP_INT_EN |
> > > > +                            HDMA_V0_REMOTE_ABORT_INT_EN;
> > > > +             }
> > > > +
> > > > +             SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
> > > > +
> > > > +             /* Channel control setup */
> > > > +             val =3D GET_CH_32(dw, chan->dir, chan->id, control1);
> > > > +             val &=3D ~HDMA_V0_LINKLIST_EN;
> > > > +             SET_CH_32(dw, chan->dir, chan->id, control1, val);
> > > > +
> > > > +             SET_CH_32(dw, chan->dir, chan->id, doorbell,
> > > > +                       HDMA_V0_DOORBELL_START);
> > > > +     }
> > > > +}
> > > > +
> > > > +static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk,
> > > > +bool
> > > > +first) {
> > > > +     struct dw_edma_chan *chan =3D chunk->chan;
> > > > +
> > > > +     if (chan->non_ll)
> > > > +             dw_hdma_v0_core_non_ll_start(chunk);
> > > > +     else
> > > > +             dw_hdma_v0_core_ll_start(chunk, first); }
> > > > +
> > > >  static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
> {
> > > >       struct dw_edma *dw =3D chan->dw; diff --git
> > > > a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > index eab5fd7..7759ba9 100644
> > > > --- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > @@ -12,6 +12,7 @@
> > > >  #include <linux/dmaengine.h>
> > > >
> > > >  #define HDMA_V0_MAX_NR_CH                    8
> > > > +#define HDMA_V0_CH_EN                                BIT(0)
> > > >  #define HDMA_V0_LOCAL_ABORT_INT_EN           BIT(6)
> > > >  #define HDMA_V0_REMOTE_ABORT_INT_EN          BIT(5)
> > > >  #define HDMA_V0_LOCAL_STOP_INT_EN            BIT(4)
> > > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > > index 3080747..78ce31b 100644
> > > > --- a/include/linux/dma/edma.h
> > > > +++ b/include/linux/dma/edma.h
> > > > @@ -99,6 +99,7 @@ struct dw_edma_chip {
> > > >       enum dw_edma_map_format mf;
> > > >
> > > >       struct dw_edma          *dw;
> > > > +     bool                    non_ll;
> > > >  };
> > > >
> > > >  /* Export to the platform drivers */
> > > > --
> > > > 1.8.3.1
> > > >

