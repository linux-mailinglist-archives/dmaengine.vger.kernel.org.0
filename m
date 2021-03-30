Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBB9B34F00D
	for <lists+dmaengine@lfdr.de>; Tue, 30 Mar 2021 19:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhC3RqG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 30 Mar 2021 13:46:06 -0400
Received: from mail-bn8nam12on2065.outbound.protection.outlook.com ([40.107.237.65]:25240
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230071AbhC3Rpt (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 30 Mar 2021 13:45:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oP6jhpUr0VHDTflAqwCG4ZYrWKVNI11L8/2LXC0c5Q66sfkOJzC+T62LlLGLYtvA3QQQPPiciSB3R6IE4fDhTbcstQXb52Wwcl7pKbdTBZ9Vi7fsf0CQvLcc5OlXWhKjqHSE+7AdpI4DEwkhJWc3KHxU2jhrYv+FdX65e85M4cIVupGFwBTy6lY571h4MPuprSt85PgTKel2MG0PU1gQgSpf9QFC26JjO2j7Vtkl/t7HiJg8RhAxJDdOOtnh0kg8VkrLIxSPEKZCX8g4j/jXBJBoaJ98oIFIl2EvMf1pHBSBpOGYJX/jbQifj/l5S2rxk5A5vSg0uFfx5kwCaYoKRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/iXBFvtSh8OaddluHQ35aHLany+ln9jU12ezXWsoDk=;
 b=Rwny7Crhd6kmzc2CtJphKL3NiYi729xZ4Zzuo01JeScGKfKpgB8HNzDikYZBYNFlTXr8EbaUuaaub4uf5wDEk3cDGk9uvyQTKC7JvOUBrnXkU2lKgHbEwAVpqGSB2/Fvr3nle3m7ADIg29DYJe8CouUjJ+E2985btR9GdxZ0fHjN+dJOUojD7kFfIHjRs7b/+UuqyWro5hMcVjoImW9oupokjb22s7ChJqMpqYs0jPkRv+j4mhpgRpxjLGkn/tyLX1Vz+xgE9tvEmnE3eG1ktqtcw4nGT6vetzF5dwBzttPFDerltzB53uxTqknZJ0N6hQwglUOzup6XaGqwXTH3tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/iXBFvtSh8OaddluHQ35aHLany+ln9jU12ezXWsoDk=;
 b=GogroGtvny+vSrShQQWXzNOqHiCLPsrvQdKimUXkeVJd65VSAOc6hZ17uEru66j0CWq+rYEAs/9wetPe7bSEhIxFPccbezl6um5irkGUq9HFVz+n2vMZQxS0FWy6cYB1X3t3prMAtVF4x3YpA5BPG3xL5G+0H7Uq5emDJ+PaqnVEycScoFWznKJjWIzBEq47IVd0gBtLySq7suQy7lf/gd1Ui/nYCITaiyNoDQoAE3SJ1sKRWPE9oSemIhpOrvl82H+j/pKSuAl9S9Ngt1VMSx9pAZa9HbHnkRcltHkx1nEXrs41m85gq17YNLPk8t/pcfS4kgg7eshSuksg5x2Y/g==
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM5PR12MB1145.namprd12.prod.outlook.com (2603:10b6:3:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.33; Tue, 30 Mar
 2021 17:45:48 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::1c62:7fa3:617b:ab87%6]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 17:45:48 +0000
Date:   Tue, 30 Mar 2021 14:45:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vkoul@kernel.org, Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH v8 0/8] idxd 'struct device' lifetime handling fixes
Message-ID: <20210330174546.GW2356281@nvidia.com>
References: <161668743322.2670112.2302120522403482843.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161668743322.2670112.2302120522403482843.stgit@djiang5-desk3.ch.intel.com>
X-Originating-IP: [142.162.115.133]
X-ClientProxiedBy: BLAPR03CA0041.namprd03.prod.outlook.com
 (2603:10b6:208:32d::16) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BLAPR03CA0041.namprd03.prod.outlook.com (2603:10b6:208:32d::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend Transport; Tue, 30 Mar 2021 17:45:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lRIR0-005yLJ-GH; Tue, 30 Mar 2021 14:45:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7587bf40-a68c-496a-c83f-08d8f3a3a6f0
X-MS-TrafficTypeDiagnostic: DM5PR12MB1145:
X-Microsoft-Antispam-PRVS: <DM5PR12MB11454F9CF6B93C617879B81CC27D9@DM5PR12MB1145.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SunbFjLGRNTfPy4WmGh8IkET+nuKrZpi7I3AgToz+IjXR3pN+jOoUKZWNA7wbBgGI+g14GhYFxvQtmaG+dnWccCtJ06+ltY4+4UyppFSLkvgvF+F3poZAZ3EAO4fG8LOfsbxIfT+ZKLufFc7i4aKCsMYPmZirtDuhT6rMHnr3jFpWMsMDQejG0Bo22Evyd7pRLbUOzXQKy6tov6mko+8rPVrc11vxuzqTxJD91c2rA8zQLkBT9XBVPeqGdOvQ6GFj6eXE3h2AQQwoEPEE1XOVf7xMkLPmqNb+82FiQ738xaMKPIGuhDjdhpIFbp1/wG94pzP9ElFHTR6XoO2RV8UXNqSnZtkUBgxCgbfjMJRq4487yhSzHJhVyGNKttJ2CUDUYvM2gwjDIOCJs7UUkxXr1jrCye5ypGcMU0i8GhaX7CzjKUCgPilhTCVD0Q0yTRx62fQ7jIa1pTq0cbsV/sy/OhOYoCbXvemRxeAxyh7A69OgLNdINw9B+CBK1yGr7G7rhTuK+jsAQXb46f82lcgs8bPy4vQ/cVhUY9eX0kjtHBdgf3PZXje+FgI8bMCxxTFgr5DZVxtDOd980fK8snW7MukeEtlkoyb+58xJX6Ev+VOhZHbbiIAmQtUbVwUYHUTE7YYUTDypCjg/7e3WQPkydHhiIjjK6LOc+ypCToYkQE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3834.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(366004)(39860400002)(376002)(346002)(33656002)(9746002)(186003)(66556008)(66946007)(66476007)(36756003)(8676002)(38100700001)(4326008)(26005)(1076003)(8936002)(9786002)(2906002)(5660300002)(478600001)(316002)(426003)(86362001)(2616005)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?AtI5lcXtWCK4GkOlGEvnf0D4e6IIyAySQ+957gqP2sWsu2we8dr0+4ZpNqk+?=
 =?us-ascii?Q?sAq26pP7ZzlC8mUeLfbRXRuHfKzEjB+qYku3L5KosVY+uusRm4ZqUi7oLiSZ?=
 =?us-ascii?Q?OJImItWE57oxHROWEcp9RWb9iGOXGx5tG6xaZ0odArMLCoVsq2JIku0A5/nY?=
 =?us-ascii?Q?9l2gbl4KajTJCc/sorlMjXuQIcllnPd8C5CojPSwCkEClit2OoAY92MWWIbS?=
 =?us-ascii?Q?GnLQfv11wGulhlyKMOAPCi7BaZ8SdG4bPClNqGU3/XPUCQI0KNx/bj9Gj2Ka?=
 =?us-ascii?Q?dfnik0KWC5yuCoXYNssxFqtB8xnJOWbTL0VbdxEYOtdjQ9OW+2A6QXHNlCD4?=
 =?us-ascii?Q?gbSxWCwRL2hWufyKvKSW2WwQOMOl6ZT+XOMkE2VGlwG2KR+WDxorqwxH4Na/?=
 =?us-ascii?Q?LTFwpHDxmeC426qBlpnp7FMkmEoAQpafOzda7qReIMenObu90hHShiZAEp3L?=
 =?us-ascii?Q?pAG3tSfrOjjtrU4cR0q8oq4no2MLKrHOEtpc9GRdLPZri/qL8IXGj/0VpCNm?=
 =?us-ascii?Q?YP/aKl8gHlbTXz5GbRUNILV1blnfPGiJMIHIRCbANctmgFQtEYaYtfI+v7KT?=
 =?us-ascii?Q?OZKcjVxLwqFNcUoAwMLDeDdKG+SaMVchWv73JZwc6umG5exQw5LYinmVK/j5?=
 =?us-ascii?Q?kv/b9x7YN9XVyeYyprSQKv4E3asHVSUducHYFn5jP7wEYoXaVQDDcgPIQVai?=
 =?us-ascii?Q?76z3vNADxRkfYG4VcdUboknmYqhjolMrvnCVcVswpixH6Apj4pMvP6cYF8wb?=
 =?us-ascii?Q?P8ic73FD7p/BAT4wtNB2+XvIuM2FUx/rLZHAxejTxiyVAujNwVg6nR6qVmNo?=
 =?us-ascii?Q?7VTzNNdUxmMBWphcWYwaCnVSg4XEts0MERsqSL07KZ/7XNR9x5Gk+EgXCVRn?=
 =?us-ascii?Q?KIo93d3U/11LZMSQHBLmndCynwBoZQpZ0Bq6PbZt/kBeuuezo89k+GXYB1gb?=
 =?us-ascii?Q?JbTpnIJiDoBrPUmfxJFDUXpufmXtDmwD8s23sRE8qymYEC3pyIcQjgN8jhyT?=
 =?us-ascii?Q?amkIeNVqrbnZi8ehJcMfpW+ZfVsTk9PJ/tn4W4h0TVsbzs7YkGHOWRaj2xAn?=
 =?us-ascii?Q?xatBF9NCXhtdyzQCu+rUC2aJOXFIFBnx33aam37gLbjQHwEaowAFSKgKfSKW?=
 =?us-ascii?Q?BcKPfaG92A+VNfS6nq3WKC7W/wi+7zww/a+kt1gpNVnhVh2bviKIi+QXx0rh?=
 =?us-ascii?Q?7ZvEpKWA2RsBc9xO85ho9MBiGgBjdW94iNjrZBbbtg2CZ5b7uGtVj0hAvPbb?=
 =?us-ascii?Q?Hux704aY/cGRzVudHD1T5ydUTmq4rMhbV1jgjh5RA8XXJS/bGXFXZ2F8UPfO?=
 =?us-ascii?Q?jiuyWcio8PC0wbpM4Ns2JckTis9kzp44oy9TMCDBET9Ydg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7587bf40-a68c-496a-c83f-08d8f3a3a6f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3834.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 17:45:48.0790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zso2J5WuAYjsiCFCjm4FdWDMP6fO78t+B6wLWyL5OwvNQKpH7ozKBqOCUoCpw5GE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 25, 2021 at 08:54:31AM -0700, Dave Jiang wrote:

> Vinod,
> The series fixes the various 'struct device' lifetime handling in the
> idxd driver. The devm managed lifetime is incompatible with 'struct device'
> objects that resides in the idxd context. Tested with
> CONFIG_DEBUG_KOBJECT_RELEASE and address all issues from that.
> 
> Please consider for damengine/fixes for the 5.12-rc.

It seems like an improvement..

The flow around probe is still weird:

static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
{
	idxd = idxd_alloc(pdev);
        ^^ but we don't device_initialize() this

	rc = idxd_probe(idxd);
	if (rc)
		goto err;

 err:
 err_iomap:
	idxd_free(idxd);
 
static int idxd_probe(struct idxd_device *idxd)
{

 err_int:
	idxd_free(idxd);
	return rc;

So we call idxd_free twice on error unwinds, and that will
crash. Unify idxd_free() and idxd_conf_device_release() as
appropriate.

Confused why they are different, why are some of the kfrees missing
from the release function?

Call device_initialize in idxd_alloc() and make it so that the release
function works properly. Move all the error unwind put_device's to
idxd_pci_probe()

..

	idxd->id = idr_alloc(&idxd_idrs[idxd->type], idxd, 0, 0, GFP_KERNEL);

Nothing ever reads the idxd_idr, so this should be an ida

Jason
